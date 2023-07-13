import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  const factory Task(
      {required String id,
      required String text,
      @Default('basic') String importance,
      DateTime? deadline,
      @Default(false) bool done,
      @Default('#FFFFFF') String? color,
      required DateTime createdAt,
      required DateTime changedAt,
      @Default('none') String lastUpdatedBy}) = _Task;

  factory Task.fromMap(Map<String, dynamic> res) => Task(
        id: res['id'],
        text: res['text'],
        importance: res['importance'],
        deadline: res['deadline'] != null
            ? DateTime.fromMillisecondsSinceEpoch(res['deadline'] * 1000)
            : null,
        done: res['done'] == 1,
        color: res['color'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(res['createdAt'] * 1000),
        changedAt: DateTime.fromMillisecondsSinceEpoch(res['changedAt'] * 1000),
        lastUpdatedBy: res['lastUpdatedBy'],
      );

  Map<String, Object?> toMapCustom() {
    return {
      "id": id,
      "text": text,
      "importance": importance,
      "deadline":
          deadline != null ? deadline!.millisecondsSinceEpoch ~/ 1000 : null,
      "done": done ? 1 : 0,
      "color": color,
      "createdAt": createdAt.millisecondsSinceEpoch ~/ 1000,
      "changedAt": changedAt.millisecondsSinceEpoch ~/ 1000,
      "lastUpdatedBy": lastUpdatedBy,
    };
  }

  Map<String, Object?> toJsonAnalytics() {
    return {
      "id": id,
      "text": text,
      "importance": importance,
      "deadline":
          deadline != null ? deadline!.millisecondsSinceEpoch ~/ 1000 : 'null',
      "done": done ? 1 : 0,
      "color": color,
      "createdAt": createdAt.millisecondsSinceEpoch ~/ 1000,
      "changedAt": changedAt.millisecondsSinceEpoch ~/ 1000,
      "lastUpdatedBy": lastUpdatedBy,
    };
  }
}
