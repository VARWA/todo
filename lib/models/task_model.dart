class Task {
  int localId;
  String text;
  String importance;
  DateTime? deadline;
  bool done;
  String? color;
  DateTime createdAt;
  DateTime changedAt;
  String lastUpdatedBy = 'null';

  Task({required this.localId,
    required this.text,
    this.importance = 'basic',
    this.deadline,
    this.done = false,
    this.color = "#FFFFFF",
    required this.createdAt,
    required this.changedAt,
    this.lastUpdatedBy = 'null'});

// Task.fromMap(Map<String, dynamic> res)
//     : id = res['id'],
//       text = res['task_name'],
//       completed = res['title'] == 1,
//       dateDeadline = DateTime.parse(res['date_deadline']),
//       priorityLevel = res['priority_level'];
//
// Map<String, Object?> toMap() {
//   return {
//     "id": id,
//     "task_name": text,
//     "completed": completed ? 1 : 0,
//     "date_deadline": dateDeadline.toString(),
//     "priority_level": priorityLevel,
//   };
// }
//
  @override
  String toString() {
    return 'Task: ${[
      localId,
      text,
      importance,
      deadline,
      done,
      color,
      createdAt,
      changedAt,
      lastUpdatedBy
    ]}';
  }
}
