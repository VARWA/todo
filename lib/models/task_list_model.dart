import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'task_model.dart';

class TasksListModel with ChangeNotifier {
  final _tasksList = <Task>[
    Task(
      id: 1,
      taskName: 'Наконец-то сделать экран',
      priorityLevel: 1,
      dateDeadline: DateTime.parse('2013-02-23'),
      completed: true,
    ),
    Task(
      id: 2,
      completed: false,
      taskName: 'Наконец-то сделать кнопки',
      priorityLevel: 2,
      dateDeadline: DateTime.parse('2012-12-27 13:27:00'),
    ),
    Task(
      id: 3,
      taskName: 'Наконец-то сделать все остальное',
      priorityLevel: 0,
      completed: true,
    ),
    Task(id: 4, taskName: 'Наконец-то сделать верстку', priorityLevel: 0),
    Task(
      id: 5,
      taskName: 'Наконец-то сделать фон Приоритет у дела',
      priorityLevel: 0,
      completed: true,
    ),
    Task(id: 19, taskName: 'Наконец-то сделать экран', priorityLevel: 2),
    Task(
      id: 6,
      taskName: 'Наконец-то сделать кнопки',
      priorityLevel: 0,
      dateDeadline: DateTime.tryParse(
        '2002.2.3',
      ),
      completed: true,
    ),
    Task(
      id: 7,
      taskName: 'Наконец-то сделать все остальное',
      priorityLevel: 0,
      completed: true,
    ),
    Task(
      id: 8,
      taskName: 'Наконец-то сделать верстку',
      priorityLevel: 0,
      completed: true,
    ),
    Task(
      id: 9,
      taskName: 'Наконец-то сделать фон Приоритет у дела',
      priorityLevel: 0,
      completed: true,
    ),
    Task(
      id: 10,
      taskName: 'Наконец-то сделать экран',
      priorityLevel: 0,
      completed: true,
    ),
    Task(
      id: 11,
      taskName: 'Наконец-то сделать кнопки',
      priorityLevel: 0,
      completed: false,
    ),
    Task(
        id: 12,
        taskName: 'Наконец-то сделать все остальное',
        priorityLevel: 0),
    Task(
      id: 13,
      taskName: 'Наконец-то сделать верстку',
      priorityLevel: 0,
      completed: true,
    ),
    Task(
        id: 14,
        taskName: 'Наконец-то сделать фон Приоритет у дела',
        priorityLevel: 0,
        completed: false),
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
        if (_tasksList[i].completed == false) {
          uncompletedTasks.add(_tasksList[i]);
        }
      }
      return uncompletedTasks;
    }
  }

  int get completedCount {
    int counter = 0;
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].completed) {
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
      if (_tasksList[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  void deleteTaskWithId(id) {
    id = -1;
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].id == i) {
        removeTask(i);
        break;
      }
    }
  }

  void changeComplete(index) {
    _tasksList[index].completed = !_tasksList[index].completed;
    notifyListeners();
  }

  void makeCompleted(id) {
    final index = searchTaskIndexById(id);
    _tasksList[index].completed = true;
    logger.i('Task with id $id comleted');
    notifyListeners();
  }

  void makeUncompleted(id) {
    final index = searchTaskIndexById(id);
    _tasksList[index].completed = false;
    logger.i('Task with id $id uncomleted');
    notifyListeners();
  }

  int get maxId {
    int maxId = -1;
    for (int i = 0; i < _tasksList.length; i++) {
      maxId = max(maxId, _tasksList[i].id);
    }
    if (maxId == -1) return 0;
    return maxId;
  }

  int searchIndex(Task el) {
    for (int i = 0; i < _tasksList.length; i++) {
      if (_tasksList[i].id == el.id) {
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
  void checkVizibility(){
    logger.d('КНОПКА НАЖАТА');
  }
}
