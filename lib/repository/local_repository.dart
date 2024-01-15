// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final outgoingIpAddressProvider = StateProvider<String>((ref) => '');
final outgoingPortProvider = StateProvider<int>((ref) => 1);
final outgoingStartPathProvider = StateProvider<String>((ref) => '');
final incomingIpAddressProvider = StateProvider<String>((ref) => '');
final incomingPortProvider = StateProvider<String>((ref) => '');

class LocalRepository {
  final WidgetRef ref;

  LocalRepository({
    required this.ref,
  });

  void loadInitialSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ref.read(outgoingIpAddressProvider.notifier).state =
        prefs.getString('outgoingIpAddress') ?? '';
    ref.read(outgoingPortProvider.notifier).state =
        int.tryParse(prefs.getString('outgoingPort') ?? '')!;
  }

  void saveSettings(
    String outgoingIpAddress,
    String outgoingPort,
    String outgoingStartPath,
    String incomingIpAddress,
    String incomingPort,
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('outgoingIpAddress', outgoingIpAddress);
      prefs.setString('outgoingPort', outgoingPort);
      prefs.setString('outgoingStartPath', outgoingStartPath);
      prefs.setString('incomingIpAddress', incomingIpAddress);
      prefs.setString('incomingPort', incomingPort);
      ref.read(outgoingIpAddressProvider.notifier).state = outgoingIpAddress;
      ref.read(outgoingPortProvider.notifier).state =
          int.tryParse(outgoingPort)!;
      ref.read(outgoingStartPathProvider.notifier).state = outgoingStartPath;
      ref.read(incomingIpAddressProvider.notifier).state = incomingIpAddress;
      ref.read(incomingPortProvider.notifier).state = incomingPort;

      showSnackBar(context, 'Network Settings Saved!');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
