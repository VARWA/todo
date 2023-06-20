import 'package:flutter/material.dart';
import 'package:todo/change_task_screen/widgets/priority_values.dart';

import 'task_model.dart';

class NewTaskModel extends ChangeNotifier {
  Task newTask;
  String priorityLevelString = PriorityValue.no;
  bool isNew;

  NewTaskModel({required this.newTask, required this.isNew});

  bool _haveDeadline = true;

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
    return PriorityValue.convertFromStringToInt(priorityLevelString);
  }

  void setPriorityLevel(value){
    priorityLevelString = value;
    notifyListeners();
}
}
