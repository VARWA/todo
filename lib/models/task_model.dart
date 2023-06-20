class Task {
  int id;
  String taskName;
  bool completed;
  DateTime? dateDeadline;
  int priorityLevel = 0;

  Task(
      {required this.id,
      required this.taskName,
      this.completed = false,
      this.dateDeadline,
      required this.priorityLevel});

  Task.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        taskName = res['task_name'],
        completed = res['title'] == 1,
        dateDeadline = DateTime.parse(res['date_deadline']),
        priorityLevel = res['priority_level'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "task_name": taskName,
      "completed": completed ? 1 : 0,
      "date_deadline": dateDeadline.toString(),
      "priority_level": priorityLevel,
    };
  }

  @override
  String toString() {
    return 'Task: ${toMap()}';
  }
}
