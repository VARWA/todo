import 'package:flutter/material.dart';
import 'task_model.dart';

class NewTaskModel extends ChangeNotifier {
  Task newTask;
  bool isNew;
  String _taskText = '';
  bool _haveDeadline = true;

  String get taskText => _taskText;

  bool get haveDeadline => _haveDeadline;

   setTaskText(String newText){
      _taskText = newText;
      notifyListeners();

  }

  DateTime currentDate = DateTime.now();
  DateTime? deadlineDate;

  NewTaskModel({required this.newTask, required this.isNew});

  void setInitText(String text){
    _taskText = text;
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
    newTask.priorityLevel = value;
    notifyListeners();
  }
}
