import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/theme.dart';
import 'package:laser_slides/common/widgets/custom_button.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  TextEditingController outgoingIpAddress = TextEditingController();
  TextEditingController outgoingPort = TextEditingController();
  TextEditingController outgoingStartPath = TextEditingController();
  TextEditingController incomingIpAddress = TextEditingController();
  TextEditingController incomingPort = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    outgoingIpAddress.dispose();
    outgoingPort.dispose();
    outgoingStartPath.dispose();
    incomingIpAddress.dispose();
    incomingPort.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //network settings
            const Text(
              'Network Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: outgoingIpAddress,
              hintText: '192.168.XX.XX',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: outgoingPort,
              hintText: '8000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            CustomTextField(
              controller: outgoingStartPath,
              hintText: '/',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            //checkbox (listen to incoming messages )
            CustomTextField(
              controller: incomingIpAddress,
              hintText: '192.168.X.X',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            CustomTextField(
              controller: incomingPort,
              hintText: '8080',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomButton(
              function: () {},
              textToUse: 'Save',
            ),
            Switch(
                activeColor: Colors.black,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.5),
                value: darkMode,
                onChanged: (val) {
                  ref.read(darkModeProvider.notifier).toggle();
                }),
          ],

          //ui settings
          //button for dark and list mode
        ),
      ),
    );
  }
}
