import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/widgets/custom_textfield.dart';
import 'package:laser_slides/repository/local_repository.dart';
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

  void saveSetting(BuildContext context) {
    LocalRepository localRepository = LocalRepository(ref: ref);
    localRepository.saveSettings(
      outgoingIpAddress.text,
      outgoingPort.text,
      outgoingStartPath.text,
      incomingIpAddress.text,
      incomingPort.text,
      context,
    );
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
            onPressed: () => Navigator.pushNamed(context, '/help'),
            icon: const Icon(
              Icons.info,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () => saveSetting(context),
            icon: const Icon(
              Icons.save_outlined,
              size: 35,
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
