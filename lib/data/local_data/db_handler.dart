import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import '../../models/task_model.dart';

class DBHelper {
  static Database? _db;
  Logger logger = Logger(printer: PrettyPrinter());

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

  void _createDatabase(Database db, int version) async {
    logger.i('CREATING DATABASE');
    await db.execute('''
        CREATE TABLE mytask(idp INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT NOT NULL, text TEXT NOT NULL,
        importance TEXT NOT NULL,
        deadline INTEGER,
        done INTEGER NOT NULL,
        color TEXT,
        createdAt INTEGER NOT NULL,
        changedAt INTEGER NOT NULL,
        lastUpdatedBy TEXT NOT NULL
        )''');
    await db.execute('''
        CREATE TABLE revision(id INTEGER PRIMARY KEY AUTOINCREMENT,
        rvalue INTEGER
        )''');
    db.insert('revision', {'rvalue': 0});
  }

  Future<Task> insert(Task task) async {
    logger.i('INSERTING INTO DATABASE');
    var dbClient = await db;
    await dbClient?.insert('mytask', task.toMap());
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

  Future<int> delete(String id) async {
    logger.i('DELETING TASK WITH id = $id FROM DATABASE');

    var dbClient = await db;
    return await dbClient!.delete('mytask', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Task task) async {
    logger.i('UPDATING DATABASE');
    var dbClient = await db;
    return await dbClient!
        .update('mytask', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future getRevision() async {
    var dbClient = await db;
    var queryResult =
        await dbClient!.query('revision', orderBy: 'rvalue DESC', limit: 1);
    return queryResult.map((e) => e['rvalue']).toList()[0];
  }

  Future setRevision(int newRevision) async {
    var dbClient = await db;
    return await dbClient!.insert('revision', {'rvalue': newRevision});
  }
}
