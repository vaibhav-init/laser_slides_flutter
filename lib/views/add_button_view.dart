// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/utils.dart';
import 'package:laser_slides/common/widgets/custom_button.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';
import 'package:laser_slides/controllers/sqlite_controller.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:uuid/uuid.dart';

class AddEditButtonView extends ConsumerStatefulWidget {
  final ButtonModel? buttonModel;

  const AddEditButtonView({
    super.key,
    this.buttonModel,
  });

  @override
  ConsumerState<AddEditButtonView> createState() => _AddButtonViewState();
}

class _AddButtonViewState extends ConsumerState<AddEditButtonView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.jpg',
          height: 50,
          width: 100,
        ),
        actions: [
          if (widget.buttonModel != null)
            IconButton(
              onPressed: () {
                ref
                    .watch(sqliteControllerProvider)
                    .deleteButton(widget.buttonModel!.id, context);

                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete,
                size: 30,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Label:',
                style: TextStyle(fontSize: 24),
              ),
              CustomTextField(
                controller: labelController,
                hintText: 'enter the label of text',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 25),
              const Text(
                'Button Pressed:',
                style: TextStyle(fontSize: 24),
              ),
              CustomTextField(
                controller: buttonPressedEventController,
                hintText: '/beyond/',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 25),
              const Text(
                'Button Released:',
                style: TextStyle(fontSize: 24),
              ),
              CustomTextField(
                controller: buttonReleasedEventController,
                hintText: '/',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 25),
              CustomButton(
                function: () async {
                  if (labelController.text != '' &&
                      buttonPressedEventController.text != '') {
                    String uuid = const Uuid().v1();
                    if (widget.buttonModel != null) {
                      uuid = widget.buttonModel!.id;
                    }
                    ButtonModel newButton = ButtonModel(
                      label: labelController.text,
                      id: uuid,
                      buttonReleasedEvent: buttonReleasedEventController.text,
                      buttonPressedEvent: buttonPressedEventController.text,
                    );
                    if (widget.buttonModel != null) {
                      ref
                          .watch(sqliteControllerProvider)
                          .updateButton(newButton, context);
                    } else {
                      ref
                          .watch(sqliteControllerProvider)
                          .addButton(newButton, context);
                    }

                    Navigator.pop(context);
                  } else {
                    showSnackBar(
                      context,
                      "Label and Button Pressed OSC can't be empty",
                    );
                  }
                },
                textToUse: 'Add/Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
