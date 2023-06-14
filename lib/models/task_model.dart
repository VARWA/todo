class Task {
  int? id;
  String task_name;
  bool completed;
  DateTime? date_deadline;
  int priority_level = 0;

  Task(
      {this.id,
      required this.task_name,
      this.completed = false,
      this.date_deadline,
      required this.priority_level});

  Task.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        task_name = res['task_name'],
        completed = res['title'] == 1,
        date_deadline = DateTime.parse(res['date_deadline']),
        priority_level = res['priority_level'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "task_name": task_name,
      "completed": completed ? 1 : 0,
      "date_deadline": date_deadline.toString(),
      "priority_level": priority_level,
    };
  }

  String toString() {
    return 'Task: ${this.toMap()}';
  }
}
