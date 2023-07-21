import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/patch_all_tasks_response.dart';

import '../../di/service_locator.dart';
import '../../src/logger.dart';

class ServerHandler {
  late final Dio _dio;
  late final String _baseUrl;
  late final String _token;
  final MyLogger _logger = locator<MyLogger>();

  void _loadEnv() {
    _baseUrl = dotenv.get('URL');
    _token = dotenv.get('TOKEN');
  }

  ServerHandler() {
    _dio = Dio();
    _loadEnv();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $_token',
    };
  }

  Future<GetAllTasksResponse> getTasksList() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('$_baseUrl/list');
      final data = response.data;
      _logger.v('GOT DATA FROM SERVER:'
          '${response.data}');
      return GetAllTasksResponse.fromJson(data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw WrongResponseError;
      } else if (e.response?.statusCode == 401) {
        throw AuthError;
      } else if (e.response?.statusCode == 404) {
        throw TaskNotExistsError;
      } else {
        _logger.e(e.response?.statusCode);
        throw OtherError;
      }
    }
  }

  Future<GetAllTasksResponse> patchTasksList({
    required int revision,
    required List<GlobalTask> list,
  }) async {
    try {
      var listForSending = PatchAllTasksResponse(list).toJson();
      _logger.v('DATA FOR PATCHING:'
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
      _logger.v('RESPONSE AFTER PATCHING:'
          '${response.data}');
      final data = response.data;
      return GetAllTasksResponse.fromJson(data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw WrongResponseError;
      } else if (e.response?.statusCode == 401) {
        throw AuthError;
      } else if (e.response?.statusCode == 404) {
        throw TaskNotExistsError;
      } else {
        throw OtherError;
      }
    }
  }
}
