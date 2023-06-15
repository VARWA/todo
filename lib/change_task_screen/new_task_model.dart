import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/task_model.dart';

class NewTaskModel extends ChangeNotifier {
  Task newTask;
  Logger logger = Logger(printer: PrettyPrinter());
  String priorityLevelString = 'Нет';
  bool isNew;

  NewTaskModel({required this.newTask, required this.isNew});

  bool _haveDeadline = false;

  get haveDeadline => _haveDeadline;

  DateTime currentDate = DateTime.now();
  DateTime? deadlineDate;

  void switchDeadline() {
    _haveDeadline = !_haveDeadline;
    notifyListeners();
  }

  void setDeadlineStatus(bool value) {
    _haveDeadline = value;
    notifyListeners();
  }

  int formatPriorityLevel() {
    if (priorityLevelString == 'Нет') {
      return 0;
    } else if (priorityLevelString == 'Низкий') {
      return 1;
    } else {
      return 2;
    }
  }
}
