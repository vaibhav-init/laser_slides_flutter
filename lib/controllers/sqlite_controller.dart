import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:laser_slides/repository/sqlite_repository.dart';

final sqliteControllerProvider = Provider((ref) {
  return SqliteController(
    ref: ref,
  );
});

class SqliteController {
  final ProviderRef ref;

  SqliteController({
    required this.ref,
  });

  void addButton(ButtonModel buttonModel, BuildContext context) {
    ref.watch(sqliteRepositoryProvider).addButton(buttonModel, context);
  }

  Future<List<ButtonModel>> getAllButtons() {
    return ref.watch(sqliteRepositoryProvider).getAllButtons();
  }

  void deleteButton(String id, BuildContext context) {
    ref.watch(sqliteRepositoryProvider).deleteButton(id, context);
  }

  void updateButtonOrder(int oldIndex, int newIndex, BuildContext context) {
    ref
        .watch(sqliteRepositoryProvider)
        .updateButtonOrder(oldIndex, newIndex, context);
  }

  void updateButton(ButtonModel updatedButton, BuildContext context) {
    ref.watch(sqliteRepositoryProvider).updateButton(updatedButton, context);
  }
}
