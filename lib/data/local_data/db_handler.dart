import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../di/service_locator.dart';
import '../../models/task_model.dart';
import '../../src/logger.dart';

class DBHandler {
  static Database? _db;
  final MyLogger _logger = locator<MyLogger>();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    _logger.i('INITIAL DATABASE');
    final Directory documentDirectory =
        await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Task2.db');
    var db = await openDatabase(path, version: 2, onCreate: _createDatabase);
    return db;
  }

  void _createDatabase(Database db, int version) async {
    _logger.i('CREATING DATABASE');
    await db.execute('''
        CREATE TABLE mytask(idp INTEGER PRIMARY KEY AUTOINCREMENT,
        id TEXT NOT NULL,
        text TEXT NOT NULL,
        importance TEXT NOT NULL,
        deadline INTEGER,
        done INTEGER NOT NULL,
        color TEXT,
        createdAt INTEGER NOT NULL,
        changedAt INTEGER NOT NULL,
        lastUpdatedBy TEXT NOT NULL
        )''');
    await db.execute('''
        CREATE TABLE last_server_revision(id INTEGER PRIMARY KEY AUTOINCREMENT,
        svalue INTEGER
        )''');
    db.insert('last_server_revision', {'svalue': 0});
    await db.execute('''
        CREATE TABLE database_revision(id INTEGER PRIMARY KEY AUTOINCREMENT,
        dvalue INTEGER
        )''');
    db.insert('database_revision', {'dvalue': 0});
  }

  Future<Task> insertTask(Task task) async {
    _logger.i('INSERTING INTO DATABASE TASK: $task');
    var dbClient = await db;
    incrementDatabaseRevision();
    await dbClient?.insert('mytask', task.toMapCustom());
    return task;
  }

  Future<List<Task>> getTaskList() async {
    await db;
    _logger.i('GETTING DATALIST');

    final List<Map<String, Object?>> queryResult =
        await _db!.rawQuery('SELECT * FROM mytask');

    _logger.v('Got result from database: $queryResult');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> delete(String id) async {
    _logger.i('DELETING TASK WITH id = $id FROM DATABASE');
    incrementDatabaseRevision();
    var dbClient = await db;
    return await dbClient!.delete(
      'mytask',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  rewriteAllData({
    required List<Task> newTasks,
    required int newRevision,
  }) async {
    _logger.i('REWRITING DATA IN DATABASE');
    final dbClient = await db;
    await deleteAllTasks();
    setDatabaseRevision(newRevision);
    _setLastServerRevision(newRevision);
    for (Task task in newTasks) {
      _logger.v('INSERTING INTO DATABASE WHILE REWRITE $task');

      dbClient?.insert(
        'mytask',
        task.toMapCustom(),
      );
    }
  }

  deleteAllTasks() async {
    var dbClient = await db;
    dbClient!.rawDelete("Delete from mytask");
    _logger.i('ALL TASKS DELETED');
  }

  Future<int> updateTask(Task task) async {
    _logger.i('UPDATING DATABASE');
    incrementDatabaseRevision();
    var dbClient = await db;
    return await dbClient!.update(
      'mytask',
      task.toMapCustom(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future getDatabaseRevision() async {
    var dbClient = await db;
    var queryResult = await dbClient!.query(
      'database_revision',
      orderBy: 'dvalue DESC',
      limit: 1,
    );
    return queryResult.map((e) => e['dvalue']).toList()[0];
  }

  Future setDatabaseRevision(int newRevision) async {
    var dbClient = await db;
    await dbClient!.insert(
      'database_revision',
      {'dvalue': newRevision},
    );
  }

  Future<void> incrementDatabaseRevision() async {
    final int oldRevision = await getDatabaseRevision();
    final int newRevision = oldRevision + 1;
    _logger.i('Local revision update: $oldRevision -> $newRevision');
    await setDatabaseRevision(newRevision);
  }

  Future getLastServerRevision() async {
    var dbClient = await db;
    var queryResult = await dbClient!.query(
      'last_server_revision',
      orderBy: 'svalue DESC',
      limit: 1,
    );
    return queryResult.map((e) => e['svalue']).toList()[0];
  }

  Future _setLastServerRevision(int newRevision) async {
    var dbClient = await db;
    await dbClient!.insert(
      'last_server_revision',
      {'svalue': newRevision},
    );
  }
}
