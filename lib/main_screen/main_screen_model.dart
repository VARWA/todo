import 'package:flutter/material.dart';

class MainScreenModel {
  List<Task> _global_list_tasks = [];

  List<Task> get global_list_tasks{
    if (global_list_tasks.length == 0){ loadTasks();};
    return _global_list_tasks;}

  void loadTasks() {
    for (int i = 1; i <= 7; i++) {
      _global_list_tasks.add(
        Task(index: i, task_name: 'Задача номер $i'),
      );
    }
    print(_global_list_tasks);
  }

  void updateCompleteStatus(index) {
    final last_status = _global_list_tasks[index].completed;
    if (last_status == true) {
      _global_list_tasks[index].completed = false;
    } else {
      _global_list_tasks[index].completed = true;
    }
  }

  void deleteTask(index) {
    global_list_tasks.removeAt(index);
  }
}

class Task {
  final index;
  String task_name;
  bool completed = false;
  DateTime? date_deadline;
  String? description;
  int priority_level = 0;
  DateTime? date_completed;

  Task({required this.index, required this.task_name});
}
