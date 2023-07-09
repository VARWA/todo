import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../src/logger.dart';
import 'task_model.dart';

class NewTaskModel extends ChangeNotifier {
  MyLogger logger = locator<MyLogger>();
  Task newTask;
  bool isNew;
  String taskText = '';
  bool _haveDeadline = false;
  DateTime currentDate = DateTime.now();
  DateTime? deadlineDate;

  bool get haveDeadline => _haveDeadline;

  NewTaskModel({
    required this.newTask,
    required this.isNew,
  });

  void setTaskText(String newText) {
    taskText = newText;
    notifyListeners();
  }

  void setInitHaveDeadline(bool value) {
    _haveDeadline = value;
  }

  void setInitText(String text) {
    taskText = text;
  }

  void switchDeadline() {
    _haveDeadline = !_haveDeadline;
    notifyListeners();
  }

  void setDeadlineStatus(bool value) {
    _haveDeadline = value;
    notifyListeners();
  }

  void setPriorityLevel(value) {
    newTask.importance = value;
    logger.i('Changed importance: $value');
    notifyListeners();
  }
}
