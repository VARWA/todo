import 'package:todo/models/task_model.dart';
import 'package:todo/repository/entity/global_task.dart';

abstract class TasksParser {
  static GlobalTask localToGlobalTaskParser(Task task) {
    return GlobalTask(
      id: task.id,
      text: task.text,
      importance: task.importance,
      deadline: task.deadline,
      done: task.done,
      color: task.color,
      createdAt: task.createdAt,
      changedAt: task.changedAt,
      lastUpdatedBy: task.lastUpdatedBy,
    );
  }

  static Task globalToLocalTaskParser(GlobalTask globalTask) {
    return Task(
      id: globalTask.id,
      text: globalTask.text,
      importance: globalTask.importance,
      deadline: globalTask.deadline,
      done: globalTask.done,
      color: globalTask.color,
      createdAt: globalTask.createdAt,
      changedAt: globalTask.changedAt,
      lastUpdatedBy: globalTask.lastUpdatedBy,
    );
  }
}
