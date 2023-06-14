import 'package:flutter/material.dart';

import 'models/task_model.dart';

class InheritedTaskList with ChangeNotifier {

  final List<Task> task_list;
  final Widget child;


  static InheritedTaskList? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedTaskList>();
  }


  @override
  bool updateShouldNotify(InheritedTaskList oldWidget) {
    return oldWidget.task_list != task_list;
  }
}