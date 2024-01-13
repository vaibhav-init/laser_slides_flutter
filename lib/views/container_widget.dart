import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laser_slides/models/container_model.dart';
import 'package:osc/osc.dart';

class ContainerWidget extends StatelessWidget {
  final ContainerModel containerModel;

  const ContainerWidget({
    super.key,
    required this.containerModel,
  });

  void sendOSC() {
    final oscSocket = OSCSocket(
      destination: InternetAddress('192.168.29.73'),
      destinationPort: 8000,
    );
    final oscMessage = OSCMessage('/beyond/', arguments: [1, 'hello']);
    oscSocket.send(oscMessage);
    oscSocket.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () => sendOSC(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 200.0,
              margin: const EdgeInsets.all(15.0),
              duration: const Duration(
                milliseconds: 500,
              ),
              child: Center(
                child: Text(containerModel.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
