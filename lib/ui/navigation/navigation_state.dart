class NavigationState {
  final bool? _unknown;
  String? selectedTaskId;
  bool createNewTask;

  bool get isTaskDetailsScreen => selectedTaskId != null || createNewTask;

  bool get isTasksListScreen => !isTaskDetailsScreen && !isUnknown;

  bool get isUnknown => _unknown == true;

  NavigationState.tasksListScreen()
      : _unknown = false,
        selectedTaskId = null,
        createNewTask = false;
  NavigationState.taskDetailsScreen(this.selectedTaskId,
      {this.createNewTask = false})
      : _unknown = false;

  NavigationState.unknownScreen()
      : _unknown = true,
        selectedTaskId = null,
        createNewTask = false;
}
