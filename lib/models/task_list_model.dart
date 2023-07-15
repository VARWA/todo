import 'package:flutter/material.dart';
import 'package:todo/repository/data_client.dart';
import 'package:uuid/uuid.dart';

import '../di/service_locator.dart';
import '../firebase/firebase_worker.dart';
import '../src/logger.dart';
import '../ui/change_task_screen/elements/importance_values.dart';
import 'task_model.dart';

class TasksListModel with ChangeNotifier {
  final FirebaseWorker _firebaseWorker = locator<FirebaseWorker>();
  final MyLogger _logger = locator<MyLogger>();
  final DataClient _dataClient = locator<DataClient>();

  List<Task> _tasksList = [];

  bool _showCompleted = false;

  TasksListModel() {
    loadTasks();
  }

  loadTasks() async {
    var loadedList = await _dataClient.loadTasksFromData();
    _tasksList = loadedList;
    notifyListeners();
  }

  bool get showCompleted => _showCompleted;

  List<Task> get tasksList => _tasksList;

  List<Task> get tasksListForMenu {
    if (!_showCompleted) {
      return _tasksList;
    } else {
      List<Task> uncompletedTasks =
          _tasksList.where((element) => !element.done).toList();

      return uncompletedTasks;
    }
  }

  int get completedCount {
    return _tasksList.where((element) => element.done).length;
  }

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    _logger.i('Completed tasks are showed in list: $_showCompleted');
    notifyListeners();
  }

  int searchTaskIndexById(String id) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  Task searchTaskById({required String id}) =>
      _tasksList.firstWhere((task) => task.id == id);

  Future<void> deleteTaskWithId(id) async {
    _tasksList.removeAt(searchTaskIndexById(id));
    notifyListeners();
    await _dataClient.deleteTaskFromDB(id);
    _firebaseWorker.analytics.deleteTask(task: searchTaskById(id: id));
    loadTasks();
  }

  void switchCompleted({required String localId}) {
    final index = searchTaskIndexById(localId);
    Task oldTask = _tasksList[index];
    _tasksList[index] = _tasksList[index].copyWith(
      done: !oldTask.done,
      changedAt: DateTime.now(),
    );
    notifyListeners();
    _dataClient.updateTaskInDB(_tasksList[index]);
    _logger.i('Task with localId $localId completed status updated');
    _firebaseWorker.analytics.completedStatusUpdate(task: _tasksList[index]);
    loadTasks();
  }

  int searchIndex(Task el) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].id == el.id) {
        return i;
      }
    }
    return -1;
  }

  Future addTask({required Task task, required bool isNew}) async {
    if (isNew) {
      await _dataClient.addNewTaskIntoDB(task);
      _logger.i('Task saved, task: $task');
      _firebaseWorker.analytics.addTask(task: task);
    } else {
      await _dataClient.updateTaskInDB(task);
      _logger.i('Task remake, task: $task');
      _firebaseWorker.analytics.updateTask(task: task);
    }
    loadTasks();
  }

  Task createNewTask() {
    DateTime dateTimeNow = DateTime.now();
    return Task(
      id: const Uuid().v4(),
      text: '',
      importance: ImportanceValues.basicGlobal,
      deadline: null,
      createdAt: dateTimeNow,
      changedAt: dateTimeNow,
    );
  }

  Task createPreTask(Task? newTaskFromList) {
    _logger.i('Task for recreating : $newTaskFromList');
    if (newTaskFromList != null) {
      return newTaskFromList;
    } else {
      return createNewTask();
    }
  }
}
