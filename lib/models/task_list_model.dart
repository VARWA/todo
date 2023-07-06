import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/repository/data_client.dart';

import '../di/service_locator.dart';
import 'task_model.dart';

class TasksListModel with ChangeNotifier {
  Logger logger = Logger(printer: PrettyPrinter());
  DataClient dataClient = locator<DataClient>();

  List<Task> _tasksList = [];

  bool _showCompleted = false;

  TasksListModel() {
    loadTasks();
  }

  loadTasks() async {
    var loadedList = await dataClient.loadTaskFromData();
    _tasksList = loadedList;
    notifyListeners();
  }

  get showCompleted => _showCompleted;

  List<Task> get tasksList => _tasksList;

  List<Task> get tasksListForMenu {
    if (_showCompleted == false) {
      return _tasksList;
    } else {
      List<Task> uncompletedTasks = [];
      for (int i = 0; i < _tasksList.length; i++) {
        if (_tasksList[i].done == false) {
          uncompletedTasks.add(_tasksList[i]);
        }
      }
      return uncompletedTasks;
    }
  }

  int get completedCount {
    int counter = 0;
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].done) {
        counter++;
      }
    }
    return counter;
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

  Future addTask(Task task, isNew) async {
    if (isNew) {
      await dataClient.addNewTaskIntoDB(task);
      // _tasksList.insert(0, task);
      logger.i('Task saved, task: $task');
    } else {
      await dataClient.updateTaskInDB(task);
      // int ind = searchIndex(task);
      // _tasksList[ind] = task;
      logger.i('Task remake, task: $task');
    }
    loadTasks();
  }
}
