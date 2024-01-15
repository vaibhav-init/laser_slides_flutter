// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/utils.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final sqliteRepositoryProvider = Provider((ref) => SqliteRepository());

class SqliteRepository {
  static const String tableName = 'buttonsList1';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'buttonsDB1.db'),
      onCreate: (database, version) async {
        await database.execute(
          """CREATE TABLE $tableName(
           id TEXT PRIMARY KEY,  
           label TEXT NOT NULL,
           buttonPressedEvent TEXT NOT NULL,
           buttonReleasedEvent TEXT NOT NULL
           )""",
        );
      },
      version: 1,
    );
  }

  Future<void> addButton(
    ButtonModel button,
    BuildContext context,
  ) async {
    try {
      final Database db = await initializeDB();
      await db.insert(
        tableName,
        button.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<ButtonModel>> getAllButtons() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => ButtonModel.fromMap(e)).toList();
  }

  Future<void> deleteButton(
    String id,
    BuildContext context,
  ) async {
    try {
      final db = await initializeDB();
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateButtonOrder(
    int oldIndex,
    int newIndex,
    BuildContext context,
  ) async {
    try {
      final db = await initializeDB();
      final List<ButtonModel> allButtons = await getAllButtons();

      if (oldIndex >= 0 &&
          oldIndex < allButtons.length &&
          newIndex >= 0 &&
          newIndex < allButtons.length) {
        final ButtonModel movedButton = allButtons.removeAt(oldIndex);
        allButtons.insert(newIndex, movedButton);
        await db.delete(tableName);
        for (final ButtonModel button in allButtons) {
          await db.insert(
            tableName,
            button.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateButton(
    ButtonModel updatedButton,
    BuildContext context,
  ) async {
    try {
      final db = await initializeDB();
      await db.update(
        tableName,
        updatedButton.toMap(),
        where: 'id = ?',
        whereArgs: [updatedButton.id],
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
