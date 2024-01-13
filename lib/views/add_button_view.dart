import 'package:flutter/material.dart';
import 'package:laser_slides/common/widgets/custom_button.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:laser_slides/repository/local_storage_repository.dart';
import 'package:uuid/uuid.dart';

class AddEditButtonView extends StatefulWidget {
  final ButtonModel? buttonModel;

  const AddEditButtonView({
    super.key,
    this.buttonModel,
  });

  @override
  State<AddEditButtonView> createState() => _AddButtonViewState();
}

class _AddButtonViewState extends State<AddEditButtonView> {
  TextEditingController labelController = TextEditingController();
  TextEditingController buttonPressedEventController = TextEditingController();
  TextEditingController buttonReleasedEventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.buttonModel != null) {
      labelController.text = widget.buttonModel!.label;
      buttonPressedEventController.text =
          widget.buttonModel!.buttonPressedEvent;
      buttonReleasedEventController.text =
          widget.buttonModel!.buttonReleasedEvent;
    }
  }

  final SqliteService sqliteService = SqliteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextField(
              controller: labelController,
              hintText: 'enter the label of text',
              keyboardType: TextInputType.text),
          CustomTextField(
            controller: buttonPressedEventController,
            hintText: 'enter the osc command for ',
            keyboardType: TextInputType.text,
          ),
          CustomTextField(
              controller: buttonReleasedEventController,
              hintText: 'enter button released osc command',
              keyboardType: TextInputType.text),
          CustomButton(
            function: () async {
              if (labelController.text != '' &&
                  buttonPressedEventController.text != '' &&
                  buttonReleasedEventController.text != '') {
                String uuid = const Uuid().v1();
                if (widget.buttonModel != null) {
                  uuid = widget.buttonModel!.id;
                }
                ButtonModel newButton = ButtonModel(
                  label: labelController.text,
                  id: uuid,
                  buttonReleasedEvent: buttonPressedEventController.text,
                  buttonPressedEvent: buttonReleasedEventController.text,
                );
                if (widget.buttonModel != null) {
                  await sqliteService.updateButton(newButton);
                } else {
                  await sqliteService.addButton(newButton);
                }
              }
              Navigator.pop(context);
            },
            textToUse: 'Add/Update',
          ),
        ],
      ),
    );
  }
}
