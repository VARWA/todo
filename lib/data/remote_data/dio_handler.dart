import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:todo/data/remote_data/server_errors.dart';
import 'package:todo/repository/entity/get_all_tasks_response.dart';
import 'package:todo/repository/entity/global_task.dart';
import 'package:todo/repository/entity/patch_all_tasks_response.dart';

class DioHelper {
  late final Dio _dio;
  final String _baseUrl = dotenv.env['URL']!;
  final String _token = dotenv.env['TOKEN']!;
  Logger logger = Logger(printer: PrettyPrinter());

  DioHelper() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {'Authorization': 'Bearer $_token'};
  }

  Future<GetAllTasksResponse> getTasksList() async {
    final response = await _dio
        .get<Map<String, dynamic>>('$_baseUrl/list'); // todo: add token
    if (response.statusCode == 200) {
      final data = response.data;
      logger.i('GOT DATA FROM SERVER:'
          '${response.data}');
      return GetAllTasksResponse.fromJson(data!);
    } else if (response.statusCode == 400) {
      throw ServerError(ServerErrorType.wrongResponseError);
    } else if (response.statusCode == 401) {
      throw ServerError(ServerErrorType.authError);
    } else if (response.statusCode == 404) {
      throw ServerError(ServerErrorType.taskNotExists);
    } else {
      throw ServerError(ServerErrorType.otherError);
    }
  }

  patchTasksList(
      {required int revision, required List<GlobalTask> list}) async {
    try {
      var listForSending = PatchAllTasksResponse(list).toJson();
      final response = await _dio.patch(
        '$_baseUrl/list',
        data: listForSending,
        options: Options(
          headers: {
            'X-Last-Known-Revision': revision.toString(),
          },
        ),
      );
      logger.i('RESPONSE AFTER PATCHING:'
          '${response.data}');
    } on DioException catch (e) {
      logger.e(e);
      // if (response.statusCode == 200) {
      //   final data = response.data;
      //   return GetAllTasksResponse.fromJson(data!);
      // } else if (response.statusCode == 400) {
      //   throw ServerError(ServerErrorType.wrongResponseError);
      // } else if (response.statusCode == 401) {
      //   throw ServerError(ServerErrorType.authError);
      // } else if (response.statusCode == 404) {
      //   throw ServerError(ServerErrorType.taskNotExists);
      // } else {
      //   throw ServerError(ServerErrorType.otherError);
      // }
    }
  }
}
