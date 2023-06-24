import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/repository/entity/all_tasks_response.dart';

class DioHelper {
  late final Dio _dio;
  final String _baseUrl = dotenv.env['URL']!;
  final String _token = dotenv.env['TOKEN']!;

  DioHelper() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {'Authorization': 'Bearer $_token'};

  }

  Future<AllTasksResponse> getTasksList() async {
    final response = await _dio.get<Map<String, dynamic>>('$_baseUrl/list'); // todo: add token
    if (response.statusCode == 200) {
      final data = response.data;
      return AllTasksResponse.fromJson(data!);
    } else if (response.statusCode == 400) {
      throw ServerErrorType.wrongResponseError;
    } else if (response.statusCode == 401) {
      throw ServerErrorType.authError;
    } else if (response.statusCode == 404) {
      throw ServerErrorType.taskNotExists;
    }
    else {
      throw ServerErrorType.otherError;
    }
  }
}
