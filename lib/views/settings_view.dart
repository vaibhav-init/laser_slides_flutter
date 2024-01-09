import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: outgoingIpAddress,
            hintText: '192.168.XX.XX',
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }
}
