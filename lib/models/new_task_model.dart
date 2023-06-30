import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'task_model.dart';

class NewTaskModel extends ChangeNotifier {
  Logger logger = Logger(printer: PrettyPrinter());
  Task newTask;
  bool isNew;
  String taskText = '';
  bool _haveDeadline = false;

  bool get haveDeadline => _haveDeadline;

  void setTaskText(String newText) {
    taskText = newText;
    notifyListeners();
  }

  void setInitHaveDeadline(bool value) {
    _haveDeadline = value;
  }

  DateTime currentDate = DateTime.now();
  DateTime? deadlineDate;

  NewTaskModel({required this.newTask, required this.isNew});

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
