import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/task_model.dart';

class NewTaskModel extends ChangeNotifier {
  late Task _newTaskModel;
  Logger logger = Logger(printer: PrettyPrinter());

  NewTaskModel({required max_id, required newTask}) {
    logger.i('Data for create PreNewTask max_Id from task_list: $max_id,'
        ' task for recreating : $newTask');
    if (newTask == null) {
      createNewTask(max_id);
    } else {
      recreateOldTask(newTask);
    }
    logger.i('PreNewTask: $_newTaskModel');
  }

  get newTaskModel => _newTaskModel;

  void recreateOldTask(task) {
    _newTaskModel = task;
  }

  void createNewTask(id) {
    _newTaskModel =
        Task(id: id + 1, task_name: '', priority_level: 0, date_deadline: null);
  }
}
