import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/parsers/tasks_parser.dart';

import '../data/remote_data/dio_handler.dart';
import '../di/service_locator.dart';
import '../src/logger.dart';

class DataClient {
  MyLogger logger = locator<MyLogger>();
  final DBHelper _dbHelper = locator<DBHelper>();
  final DioHelper _dioHelper = locator<DioHelper>();

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

  List<Task> getFormattedTasksFromDioAnswer({required GetAllTasksResponse dioAnswer}) {
    final List<GlobalTask> gotList = dioAnswer.list;
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

  Future<List<Task>> loadTasksFromData() async {
    List<Task> tasksFromDB = await loadTasksFromDB();
    logger.i('Got list from database: $tasksFromDB');

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      logger.i('NO CONNECT TO INTERNET -> load data only from database');
      return tasksFromDB;
    }

    int localRevisionFromDB = await getLocalRevisionFromDatabase();
    int oldServerRevisionFromDB = await getServerRevisionFromDatabase();

    logger.i('Got local revision from database: $localRevisionFromDB');
    logger.i('Got old server revision from database: $oldServerRevisionFromDB');

    try {
      GetAllTasksResponse dioAnswer = await loadTasksFromServer();

      int revisionFromDio = dioAnswer.revision;
      logger.i('Got revision from server $revisionFromDio');

      List<Task> tasksFromServer = getFormattedTasksFromDioAnswer(
        dioAnswer: dioAnswer,
      );
      logger.i('Got list from server after parsing: $tasksFromServer');

      if (revisionFromDio == oldServerRevisionFromDB &&
          localRevisionFromDB == revisionFromDio) {
        logger.i(
            'revisionFromDio = oldServerRevisionFromDB = revisionFromDio = $localRevisionFromDB');

        return tasksFromDB;
      } else if (localRevisionFromDB == oldServerRevisionFromDB &&
          localRevisionFromDB < revisionFromDio) {
        logger.i('localRevisionFromDB == oldServerRevisionFromDB '
            '&& localRevisionFromDB < revisionFromDio.\n'
            ' Tasks from server: $tasksFromServer');

        var formattedTasks =
            getFormattedTasksFromDioAnswer(dioAnswer: dioAnswer);
        logger.d('formatted tasks $formattedTasks');

        await _dbHelper.rewriteAllData(
            newTasks: formattedTasks, newRevision: revisionFromDio);

        List<Task> newTasksFromDB = await loadTasksFromDB();

        return newTasksFromDB;
      } else if (localRevisionFromDB != oldServerRevisionFromDB &&
          localRevisionFromDB > revisionFromDio) {
        logger.i('localRevisionFromDB != oldServerRevisionFromDB '
            '&& localRevisionFromDB > revisionFromDio.'
            ' Tasks from database: $tasksFromDB');

        await patchTasksToServer(tasksFromDB);
        dioAnswer = await loadTasksFromServer();

        int revisionFromDio = dioAnswer.revision;

        var formattedTasks =
            getFormattedTasksFromDioAnswer(dioAnswer: dioAnswer);
        logger.d('formatted tasks $formattedTasks');

        await _dbHelper.rewriteAllData(
          newTasks: formattedTasks,
          newRevision: revisionFromDio,
        );

        List<Task> newTasksFromDB = await loadTasksFromDB();

        return newTasksFromDB;
      } else {
        logger.i('''Another situation:
        localRevisionFromDB: $localRevisionFromDB,
        oldServerRevisionFromDB: $oldServerRevisionFromDB,
        revisionFromDio: ${revisionFromDio.toString()},
        ''');

        await patchTasksToServer(tasksFromDB);

        GetAllTasksResponse dioAnswer = await loadTasksFromServer();

        revisionFromDio = dioAnswer.revision;
        logger.i('Got revision from server $revisionFromDio');

        var formattedTasks =
            getFormattedTasksFromDioAnswer(dioAnswer: dioAnswer);
        logger.d('formatted tasks $formattedTasks');

        await _dbHelper.rewriteAllData(
          newTasks: formattedTasks,
          newRevision: revisionFromDio,
        );
        List<Task> newTasksFromDB = await loadTasksFromDB();

        return newTasksFromDB;
      }
    } on ServerError {
      logger.e('Server error, load tasks from Database');
      return tasksFromDB;
    } catch (e) {
      logger.e('Connection error, Check your network');
      logger.e(e);
      return tasksFromDB;
    }
  }

  void loadFromServerAndRewriteDatabase() {}

  Future<GetAllTasksResponse> loadTasksFromServer() {
    return _dioHelper.getTasksList();
  }

  Future<void> patchTasksToServer(List<Task> list) async {
    List<GlobalTask> tasksWithGlobalFormat =
        list.map((e) => TasksParser.localToGlobalTaskParser(e)).toList();
    int revision = await getLocalRevisionFromDatabase();
    _dioHelper.patchTasksList(revision: revision, list: tasksWithGlobalFormat);
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
}
