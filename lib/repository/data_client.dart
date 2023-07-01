import 'package:logger/logger.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/parsers/tasks_parser.dart';

import '../data/remote_data/dio_handler.dart';

class DataClient {
  Logger logger = Logger(printer: PrettyPrinter());
  final DBHelper _dbHelper = DBHelper();

  final DioHelper _dioHelper = DioHelper();

  Future getRevisionFromDatabase() async {
    return _dbHelper.getRevision();
  }

  Future<List<Task>> loadTasksFromDB() async {
    return _dbHelper.getDataList();
  }

  Future<List<Task>> loadTaskFromData() async {
    GetAllTasksResponse dioAnswer = await loadTasksFromServer();
    logger.i('Got revision from server ${dioAnswer.revision}');

    List<Task> tasksFromServer = dioAnswer.list
        .map((e) => TasksParser.globalToLocalTaskParser(e))
        .toList();
    logger.i('Got list from server after parsing: $tasksFromServer');

    List<Task> tasksFromDB = await loadTasksFromDB();
    logger.i('Got list from database: $tasksFromDB');

    var revisionFromDB = await getRevisionFromDatabase();
    logger.i('Got revision from database: $revisionFromDB');
    return tasksFromDB;
  }

  Future<GetAllTasksResponse> loadTasksFromServer() {
    return _dioHelper.getTasksList();
  }

  Future<GetAllTasksResponse> patchTasksToServer(List<Task> list) {
    List<GlobalTask> tasksWithGlobalFormat =
        list.map((e) => TasksParser.localToGlobalTaskParser(e)).toList();
    int revision = 0; // todo: add local revision
    return _dioHelper.patchTasksList(
        revision: revision, list: tasksWithGlobalFormat);
  }

  void addNewTaskIntoDB(Task task) async {
    await _dbHelper.insert(task);
  }

  void deleteTaskFromDB(String id) async {
    await _dbHelper.delete(id);
  }

  void updateTaskInDB(Task task) async {
    await _dbHelper.update(task);
  }
}
