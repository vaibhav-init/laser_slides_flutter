import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/utils.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:laser_slides/repository/local_repository.dart';
import 'package:osc/osc.dart';

final oscRepositoryProvider = Provider((ref) => OscRepository(
      ref: ref,
    ));

class OscRepository {
  final ProviderRef ref;

  OscRepository({required this.ref});
  void sendButtonPressedOSC(ButtonModel buttonModel, BuildContext context) {
    try {
      final destination = InternetAddress(ref.watch(outgoingIpAddressProvider));
      print(destination);
      int indexOfSpace = buttonModel.buttonPressedEvent.indexOf(' ');

      RegExp regex = RegExp(r'\d+');
      Iterable<Match> matches =
          regex.allMatches(buttonModel.buttonPressedEvent);
      List<int> arguments =
          matches.map((match) => int.parse(match.group(0)!)).toList();
      String result = buttonModel.buttonPressedEvent.substring(0, indexOfSpace);
      print(result);

      final message = OSCMessage(result, arguments: arguments);

      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
        final bytes = message.toBytes();
        socket.send(bytes, destination, ref.watch(outgoingPortProvider));
        socket.close();
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendButtonReleasedOSC(ButtonModel buttonModel, BuildContext context) {
    try {
      final destination = InternetAddress(ref.watch(outgoingIpAddressProvider));
      int indexOfSpace = buttonModel.buttonReleasedEvent.indexOf(' ');

      RegExp regex = RegExp(r'\d+');
      Iterable<Match> matches =
          regex.allMatches(buttonModel.buttonReleasedEvent);
      List<int> arguments =
          matches.map((match) => int.parse(match.group(0)!)).toList();
      String result =
          buttonModel.buttonReleasedEvent.substring(0, indexOfSpace);

      final message = OSCMessage(result, arguments: arguments);

      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
        final bytes = message.toBytes();
        socket.send(bytes, destination, ref.watch(outgoingPortProvider));
        socket.close();
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
