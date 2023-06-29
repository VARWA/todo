import 'package:todo/data/local_data/db_handler.dart';
import 'package:todo/models/task_model.dart';

class DataClient {
  final DBHelper _dbHelper = DBHelper();

  // final DioHelper _dioHelper = DioHelper();

  Future<List<Task>> loadTaskFromDB() async {
    return _dbHelper.getDataList();
  }

  void addNewTaskIntoDB(Task task) async {
    await _dbHelper.insert(task);
  }

  void deleteTaskFromDB(String id) async {
    await _dbHelper.delete(id);
  }

  void updateTaskInDB(Task task) async {
    await _dbHelper.update(task);
  }
}
