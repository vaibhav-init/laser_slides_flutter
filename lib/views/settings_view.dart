import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/theme.dart';
import 'package:laser_slides/common/widgets/custom_button.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      outgoingIpAddress.text = prefs.getString('outgoingIpAddress') ?? '';
      outgoingPort.text = prefs.getString('outgoingPort') ?? '';
      outgoingStartPath.text = prefs.getString('outgoingStartPath') ?? '';
      incomingIpAddress.text = prefs.getString('incomingIpAddress') ?? '';
      incomingPort.text = prefs.getString('incomingPort') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('outgoingIpAddress', outgoingIpAddress.text);
    prefs.setString('outgoingPort', outgoingPort.text);
    prefs.setString('outgoingStartPath', outgoingStartPath.text);
    prefs.setString('incomingIpAddress', incomingIpAddress.text);
    prefs.setString('incomingPort', incomingPort.text);
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
              function: () => saveSettings(),
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
