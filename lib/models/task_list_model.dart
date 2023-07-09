import 'package:flutter/material.dart';
import 'package:todo/repository/data_client.dart';

import '../di/service_locator.dart';
import '../src/logger.dart';
import 'task_model.dart';

class TasksListModel with ChangeNotifier {
  MyLogger logger = locator<MyLogger>();
  DataClient dataClient = locator<DataClient>();

  List<Task> _tasksList = [];

  bool _showCompleted = false;

  TasksListModel() {
    loadTasks();
  }

  loadTasks() async {
    var loadedList = await dataClient.loadTasksFromData();
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

  void rechangeShowCompleted() {
    _showCompleted = !_showCompleted;
    logger.i('Completed tasks are showed in list: $_showCompleted');
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

  Future<void> deleteTaskWithId(id) async {
    await dataClient.deleteTaskFromDB(id);
    loadTasks();
  }

  void switchCompleted(localId) {
    final index = searchTaskIndexById(localId);
    _tasksList[index].done = !_tasksList[index].done;
    _tasksList[index].changedAt = DateTime.now();
    dataClient.updateTaskInDB(_tasksList[index]);
    logger.i('Task with localId $localId completed status updated');
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
      await dataClient.addNewTaskIntoDB(task);
      logger.i('Task saved, task: $task');
    } else {
      await dataClient.updateTaskInDB(task);
      logger.i('Task remake, task: $task');
    }
    loadTasks();
  }
}
