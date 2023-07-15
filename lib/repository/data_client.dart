import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/parsers/tasks_parser.dart';

import '../data/remote_data/server_handler.dart';
import '../di/service_locator.dart';
import '../src/logger.dart';

class DataClient {
  final MyLogger _logger = locator<MyLogger>();
  final DBHandler _dbHelper = locator<DBHandler>();
  final ServerHandler _serverHelper = locator<ServerHandler>();

  DataClient._();

  static final DataClient _instance = DataClient._();

  factory DataClient() => _instance;

  Future getLocalRevisionFromDatabase() async {
    return _dbHelper.getDatabaseRevision();
  }

  Future getServerRevisionFromDatabase() async {
    return _dbHelper.getLastServerRevision();
  }

  Future<List<Task>> loadTasksFromDB() async {
    return _dbHelper.getTaskList();
  }

  List<Task> getFormattedTasksFromServerAnswer(
      {required GetAllTasksResponse serverAnswer}) {
    final List<GlobalTask> gotList = serverAnswer.list;
    List<Task> newList =
        gotList.map(TasksParser.globalToLocalTaskParser).toList();
    return newList;
  }

  Future<bool> checkTaskById(String id) async {
    List<Task> tasksList = await loadTasksFromDB();
    for (int i = 0; i < tasksList.length; i++) {
      if (tasksList[i].id == id) {
        return true;
      }
    }
    return false;
  }

  Future<List<Task>> loadTasksFromSomeData() async {
    List<Task> tasksFromDB = await loadTasksFromDB();
    _logger.v('Got list from database: $tasksFromDB');

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      _logger.i('NO CONNECT TO INTERNET -> load data only from database');
      return tasksFromDB;
    }

    int localRevisionFromDB = await getLocalRevisionFromDatabase();
    int oldServerRevisionFromDB = await getServerRevisionFromDatabase();

    _logger.i('Got local revision from database: $localRevisionFromDB');
    _logger
        .i('Got old server revision from database: $oldServerRevisionFromDB');

    try {
      GetAllTasksResponse serverAnswer = await loadTasksFromServer();

      int revisionFromServer = serverAnswer.revision;
      _logger.i('Got revision from server $revisionFromServer');

      if (revisionFromServer == oldServerRevisionFromDB &&
          localRevisionFromDB == revisionFromServer) {
        _logger.i(
            'revisionFromServer = oldServerRevisionFromDB = revisionFromServer = $localRevisionFromDB');

        return tasksFromDB;
      } else if (localRevisionFromDB == oldServerRevisionFromDB &&
          localRevisionFromDB < revisionFromServer) {
        _logger.i('localRevisionFromDB == oldServerRevisionFromDB '
            '&& localRevisionFromDB < revisionFromServer.');

        return _loadTasksFromServerAndInsertIntoDB(serverAnswer: serverAnswer);
      } else if (localRevisionFromDB != oldServerRevisionFromDB &&
          localRevisionFromDB > revisionFromServer) {
        _logger.i('localRevisionFromDB != oldServerRevisionFromDB '
            '&& localRevisionFromDB > revisionFromServer.');
        _logger.v(' Tasks from database: $tasksFromDB');
        return await _patchTasksToServerAndUpdateDB(tasksFromDB: tasksFromDB);
      } else if (localRevisionFromDB != oldServerRevisionFromDB &&
          localRevisionFromDB < revisionFromServer) {
        _logger.i(
            'localRevisionFromDB != oldServerRevisionFromDB && localRevisionFromDB < revisionFromServer');
        return await _patchTasksToServerAndUpdateDB(tasksFromDB: tasksFromDB);
      } else {
        _logger.i('''Another situation:
        localRevisionFromDB: $localRevisionFromDB,
        oldServerRevisionFromDB: $oldServerRevisionFromDB,
        revisionFromServer: ${revisionFromServer.toString()},
        ''');

        return await _patchTasksToServerAndUpdateDB(tasksFromDB: tasksFromDB);
      }
    } on ServerError {
      _logger.e('Server error, load tasks from Database');
      return tasksFromDB;
    } catch (e) {
      _logger.e('Connection error, Check your network');
      _logger.e(e);
      return tasksFromDB;
    }
  }

  Future<List<Task>> _patchTasksToServerAndUpdateDB(
      {required List<Task> tasksFromDB}) async {
    final (formattedTasks, revisionFromServer) =
        await _patchTasksToServer(tasksFromDB);

    await _dbHelper.rewriteAllData(
      newTasks: formattedTasks,
      newRevision: revisionFromServer,
    );

    List<Task> newTasksFromDB = await loadTasksFromDB();

    return newTasksFromDB;
  }

  List<Task> _loadTasksFromServerAndInsertIntoDB(
      {required GetAllTasksResponse serverAnswer}) {
    final formattedTasks =
        getFormattedTasksFromServerAnswer(serverAnswer: serverAnswer);
    _logger.v(' Tasks from server: $formattedTasks');

    _dbHelper.rewriteAllData(
        newTasks: formattedTasks, newRevision: serverAnswer.revision);

    return formattedTasks;
  }

  Future<GetAllTasksResponse> loadTasksFromServer() {
    return _serverHelper.getTasksList();
  }

  Future<(List<Task>, int)> _patchTasksToServer(List<Task> list) async {
    List<GlobalTask> tasksWithGlobalFormat =
        list.map((e) => TasksParser.localToGlobalTaskParser(e)).toList();
    int revision = await getLocalRevisionFromDatabase();
    final serverAnswer = await _serverHelper.patchTasksList(
        revision: revision, list: tasksWithGlobalFormat);
    final formattedTasks =
        getFormattedTasksFromServerAnswer(serverAnswer: serverAnswer);
    return (formattedTasks, serverAnswer.revision);
  }

  Future addNewTaskIntoDB(Task task) async {
    await _dbHelper.insertTask(task);
  }

  Future deleteTaskFromDB(String id) async {
    await _dbHelper.delete(id);
  }

  Future updateTaskInDB(Task task) async {
    await _dbHelper.updateTask(task);
  }

  Future<List<Task>> loadTasksFromData() async {
    if (kIsWeb) {
      _logger.i('Current platform is Web -> load data from server');
      return await loadTasksOnlyFromServer();
    } else if (Platform.isAndroid || Platform.isIOS) {
      _logger.i(
          'Current platform is Andriod or IOS -> load data from server and db');
      return await loadTasksFromSomeData();
    } else {
      _logger
          .i('Current platform is not Andriod or IOS -> load data from server');
      return await loadTasksOnlyFromServer();
    }
  }

  Future<List<Task>> loadTasksOnlyFromServer() async {
    try {
      GetAllTasksResponse serverAnswer = await loadTasksFromServer();
      _logger.i('Loaded tasks from server');
      final formattedTasks =
          getFormattedTasksFromServerAnswer(serverAnswer: serverAnswer);
      return formattedTasks;
    } on ServerError {
      return [];
    } catch (e) {
      _logger.e(e);
      return [];
    }
  }
}
