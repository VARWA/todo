import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/patch_all_tasks_response.dart';

class DioHelper {
  late final Dio _dio;
  late final String _baseUrl;
  late final String _token;
  Logger logger = Logger(printer: PrettyPrinter());

  void loadEnv() {
    _baseUrl = dotenv.get('URL');
    _token = dotenv.get('TOKEN');
  }
  DioHelper() {
    _dio = Dio();
     loadEnv();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_token',
    };
  }


  Future<GetAllTasksResponse> getTasksList() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('$_baseUrl/list');
      final data = response.data;
      logger.i('GOT DATA FROM SERVER:'
          '${response.data}');
      return GetAllTasksResponse.fromJson(data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerError(ServerErrorType.wrongResponseError);
      } else if (e.response?.statusCode == 401) {
        throw ServerError(ServerErrorType.authError);
      } else if (e.response?.statusCode == 404) {
        throw ServerError(ServerErrorType.taskNotExists);
      } else {
        throw ServerError(ServerErrorType.otherError);
      }
    }
  }

  patchTasksList({
    required int revision,
    required List<GlobalTask> list,
  }) async {
    try {
      var listForSending = PatchAllTasksResponse(list).toJson();
      logger.i('Data for patching:'
          '$listForSending, \n revision: ${revision - 1}');
      final response = await _dio.patch(
        '$_baseUrl/list',
        data: listForSending,
        options: Options(
          headers: {
            'X-Last-Known-Revision': (revision - 1).toString(),
          },
        ),
      );
      logger.i('RESPONSE AFTER PATCHING:'
          '${response.data}');
      final data = response.data;
      return GetAllTasksResponse.fromJson(data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerError(ServerErrorType.wrongResponseError);
      } else if (e.response?.statusCode == 401) {
        throw ServerError(ServerErrorType.authError);
      } else if (e.response?.statusCode == 404) {
        throw ServerError(ServerErrorType.taskNotExists);
      } else {
        throw ServerError(ServerErrorType.otherError);
      }
    }
  }
}
