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

  Task(
      {required this.localId,
      required this.text,
      this.importance = 'basic',
      this.deadline,
      this.done = false,
      this.color = "#FFFFFF",
      required this.createdAt,
      required this.changedAt,
      this.lastUpdatedBy = 'null'});

  Task.fromMap(Map<String, dynamic> res)
      : localId = res['localId'],
        text = res['text'],
        importance = res['importance'],
        deadline = res['deadline'] != null
            ? DateTime.fromMillisecondsSinceEpoch(res['deadline'] * 1000)
            : null,
        done = res['done'] == 1,
        color = res['color'],
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(res['createdAt'] * 1000),
        changedAt =
            DateTime.fromMillisecondsSinceEpoch(res['changedAt'] * 1000),
        lastUpdatedBy = res['lastUpdatedBy'];

  Map<String, Object?> toMap() {
    return {
      "localId": localId,
      "text": text,
      "importance": importance,
      "deadline":
          deadline != null ? deadline!.millisecondsSinceEpoch ~/ 1000 : null,
      "done": done ? 1 : 0,
      "color": color,
      "createdAt": createdAt.millisecondsSinceEpoch ~/ 1000,
      "changedAt": changedAt.millisecondsSinceEpoch ~/ 1000,
      "lastUpdatedBy": lastUpdatedBy
    };
  }

  @override
  String toString() {
    return 'Task: ${toMap()}';
  }
}
