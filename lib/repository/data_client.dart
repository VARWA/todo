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

  void deleteTaskFromDB(int localId) async {
    await _dbHelper.delete(localId);
  }

  void updateTaskInDB(Task task) async {
    await _dbHelper.update(task);
  }
}
