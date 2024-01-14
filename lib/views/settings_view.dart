// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/utils.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

final outgoingIpAddressProvider = StateProvider<String>((ref) => '');
final outgoingPortProvider = StateProvider<String>((ref) => '');
final outgoingStartPathProvider = StateProvider<String>((ref) => '');
final incomingIpAddressProvider = StateProvider<String>((ref) => '');
final incomingPortProvider = StateProvider<String>((ref) => '');

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
    ref.read(outgoingIpAddressProvider.notifier).state = outgoingIpAddress.text;
    ref.read(outgoingPortProvider.notifier).state = outgoingPort.text;
    ref.read(outgoingStartPathProvider.notifier).state = outgoingStartPath.text;
    ref.read(incomingIpAddressProvider.notifier).state = incomingIpAddress.text;
    ref.read(incomingPortProvider.notifier).state = incomingPort.text;

    showSnackBar(context, 'Network Settings Saved!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Network Settings',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: saveSettings,
            icon: const Icon(
              Icons.info,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: saveSettings,
            icon: const Icon(
              Icons.save_outlined,
              size: 30,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Outgoing',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 15),
              const Text(
                'IP Address:',
                style: TextStyle(fontSize: 18),
              ),
              CustomTextField(
                controller: outgoingIpAddress,
                hintText: '192.168.XX.XX',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              const Text(
                'Port:',
                style: TextStyle(fontSize: 18),
              ),
              CustomTextField(
                controller: outgoingPort,
                hintText: '8000',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              const Text(
                'Start Path:',
                style: TextStyle(fontSize: 18),
              ),
              CustomTextField(
                controller: outgoingStartPath,
                hintText: '/',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              const Text(
                'Incoming',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 15),
              const Text(
                'IP Address:',
                style: TextStyle(fontSize: 18),
              ),
              CustomTextField(
                controller: incomingIpAddress,
                hintText: '192.168.X.X',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              const Text(
                'Port:',
                style: TextStyle(fontSize: 18),
              ),
              CustomTextField(
                controller: incomingPort,
                hintText: '8080',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
