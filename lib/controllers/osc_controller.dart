import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:laser_slides/repository/osc_repository.dart';

final oscControllerProvider = Provider((ref) {
  return OscController(
    ref: ref,
  );
});

class OscController {
  final ProviderRef ref;

  OscController({
    required this.ref,
  });

  void sendButtonPressedOSC(ButtonModel buttonModel, BuildContext context) {
    ref.watch(oscRepositoryProvider).sendButtonPressedOSC(
          buttonModel,
          context,
        );
  }

  void sendButtonReleasedOSC(ButtonModel buttonModel, BuildContext context) {
    ref.watch(oscRepositoryProvider).sendButtonReleasedOSC(
          buttonModel,
          context,
        );
  }
}
