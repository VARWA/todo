import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import '../models/task_model.dart';

class DBHelper {
  static Database? _db;
  var logger = Logger(printer: PrettyPrinter());

  Future<Database?> get db async {
    logger.i('GETTING DATABASE');
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    logger.i('INITIAL DATABASE');
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Task.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    logger.i('CREATING DATABASE');
    await db.execute(
        "CREATE TABLE mytask(id INTEGER PRIMARY KEY AUTOINCREMENT, localId INT NOT NULL, text TEXT NOT NULL, importance TEXT NOT NULL, deadline INTEGER, done INTEGER NOT NULL, color TEXT, createdAt INTEGER NOT NULL, changedAt INTEGER NOT NULL, lastUpdatedBy TEXT NOT NULL)");
  }

  Future<Task> insert(Task task) async {
    logger.i('INSERTING INTO DATABASE');
    var dbclient = await db;
    await dbclient?.insert('mytask', task.toMap());
    return task;
  }

  Future<List<Task>> getDataList() async {
    await db;
    logger.i('GETTING DATALIST');

    final List<Map<String, Object?>> queryResult =
        await _db!.rawQuery('SELECT * FROM mytask');
    logger.d(queryResult);
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> delete(int localId) async {
    logger.i('DELETING TASK WITH $localId FROM DATABASE');

    var dbClient = await db;
    return await dbClient!
        .delete('mytask', where: 'localId = ?', whereArgs: [localId]);
  }

  Future<int> update(Task task) async {
    logger.i('UPDATING DATABASE');
    var dbClient = await db;
    return await dbClient!.update('mytask', task.toMap(),
        where: 'localId = ?', whereArgs: [task.localId]);
  }
}
