import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'models/task_model.dart';

class TasksListModel with ChangeNotifier {
  final _tasks_list = <Task>[
    Task(id: 1, task_name: 'Наконец-то сделать экран', priority_level: 1),
    Task(
        id: 2,
        completed: true,
        task_name: 'Наконец-то сделать кнопки',
        priority_level: 0),
    Task(
        id: 3,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 4, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 5,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
    Task(id: 1, task_name: 'Наконец-то сделать экран', priority_level: 2),
    Task(
        id: 6,
        task_name: 'Наконец-то сделать кнопки',
        priority_level: 0,
        date_deadline: DateTime.tryParse('2002.2.3')),
    Task(
        id: 7,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 8, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 9,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
    Task(id: 10, task_name: 'Наконец-то сделать экран', priority_level: 0),
    Task(id: 11, task_name: 'Наконец-то сделать кнопки', priority_level: 0),
    Task(
        id: 12,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 13, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 14,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
  ];
  bool _showCompleted = false;
  Logger logger = Logger(printer: PrettyPrinter());

  get showCompleted => _showCompleted;

  List<Task> get tasks_list {
    if (_showCompleted == false) {
      return _tasks_list;
    } else {
      List<Task> uncompleted_tasks = [];
      for (int i = 0; i < _tasks_list.length; i++) {
        if (_tasks_list[i].completed) {
          uncompleted_tasks.add(_tasks_list[i]);
        }
      }
      return uncompleted_tasks;
    }
  }

  int get completed_count {
    int counter = 0;
    for (int i = 0; i < _tasks_list.length; i++) {
      if (_tasks_list[i].completed) {
        counter++;
      }
    }
    notifyListeners();
    return counter;
  }

  void rechangeShowCompleted() {
    _showCompleted = !_showCompleted;
    logger.i('Completed tasks are showed in list: $_showCompleted');
    notifyListeners();
  }

  void removeTask(index) {
    _tasks_list.removeAt(index);
    logger.i('Task with index $index removed');
    notifyListeners();
  }

  void changeComplete(index) {
    _tasks_list[index].completed = !_tasks_list[index].completed;
    notifyListeners();
  }

  void makeCompleted(index) {
    _tasks_list[index].completed = true;
    logger.i('Task with index $index comleted');
    notifyListeners();
  }

  void makeUncompleted(index) {
    _tasks_list[index].completed = false;
    logger.i('Task with index $index uncomleted');
    notifyListeners();
  }
}
