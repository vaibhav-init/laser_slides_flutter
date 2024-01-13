import 'package:laser_slides/models/button_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
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

  Future<void> addButton(ButtonModel button) async {
    final Database db = await initializeDB();
    await db.insert(
      tableName,
      button.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ButtonModel>> getAllButtons() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => ButtonModel.fromMap(e)).toList();
  }

  Future<void> deleteButton(String id) async {
    final db = await initializeDB();
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      //show a scaffold later !!!
    }
  }

  Future<void> updateButtonOrder(int oldIndex, int newIndex) async {
    final db = await initializeDB();
    final List<ButtonModel> allButtons = await getAllButtons();
    print('function called !!!!');

    if (oldIndex >= 0 &&
        oldIndex < allButtons.length &&
        newIndex >= 0 &&
        newIndex < allButtons.length) {
      print('inside the condition !!!');
      final ButtonModel movedButton = allButtons.removeAt(oldIndex);
      allButtons.insert(newIndex, movedButton);

      for (int i = 0; i < allButtons.length; i++) {
        final ButtonModel button = allButtons[i];
        await db.update(
          tableName,
          button.toMap(),
          where: 'id = ?',
          whereArgs: [button.id],
        );
      }
    }
  }

  Future<void> updateButton(ButtonModel updatedButton) async {
    final db = await initializeDB();

    await db.update(
      tableName,
      updatedButton.toMap(),
      where: 'id = ?',
      whereArgs: [updatedButton.id],
    );
  }
}
