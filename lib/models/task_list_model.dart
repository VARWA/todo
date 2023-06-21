import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'task_model.dart';

class TasksListModel with ChangeNotifier {
  final _tasksList = <Task>[
    Task(
      localId: 1,
      text: 'Наконец-то сделать экран',
      importance: 'high',
      deadline: DateTime.now(),
      done: true,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      localId: 2,
      text: 'Нaконец-то добавить локализацию',
      importance: 'low',
      deadline: DateTime.now(),
      done: false,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
    Task(
      localId: 3,
      text: 'Наконец сделать домашку',
      importance: 'basic',
      deadline: DateTime.now(),
      done: true,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
    ),
  ];
  bool _showCompleted = false;
  Logger logger = Logger(printer: PrettyPrinter());

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

  void removeTask(index) {
    _tasksList.removeAt(index);
    logger.i('Task with index $index removed');
    notifyListeners();
  }

  int searchTaskIndexById(id) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].localId == id) {
        return i;
      }
    }
    return -1;
  }

  void deleteTaskWithId(id) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].localId == id) {
        removeTask(i);
        logger.i('$Task with $id deleted');
        notifyListeners();
        return;
      }
    }

  }

  void changeComplete(index) {
    _tasksList[index].done = !_tasksList[index].done;
    notifyListeners();
  }

  void makeCompleted(id) {
    final index = searchTaskIndexById(id);
    _tasksList[index].done = true;
    logger.i('Task with id $id comleted');
    notifyListeners();
  }

  void makeUncompleted(id) {
    final index = searchTaskIndexById(id);
    _tasksList[index].done = false;
    logger.i('Task with id $id uncomleted');
    notifyListeners();
  }

  int get maxId {
    int maxId = -1;
    for (int i = 0; i < _tasksList.length; i++) {
      maxId = max(maxId, _tasksList[i].localId);
    }
    if (maxId == -1) return 0;
    return maxId;
  }

  int searchIndex(Task el) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].localId == el.localId) {
        return i;
      }
    }
    return -1;
  }

  void addTask(Task task, isNew) {
    if (isNew) {
      _tasksList.insert(0, task);
      logger.i('Task saved, task: $task');
    } else {
      int ind = searchIndex(task);
      _tasksList[ind] = task;
      logger.i('Task remake, task: $task');
    }
    notifyListeners();
  }

  void checkVizibility() {
    logger.d('КНОПКА НАЖАТА');
  }
}
