// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:todo/data/remote_data/server_errors.dart';
// import 'package:todo/repository/entity/get_all_tasks_response.dart';
// import 'package:todo/repository/entity/global_task.dart';
// import 'package:todo/repository/entity/patch_all_tasks_response.dart';
//
// import '../../di/service_locator.dart';
// import '../../src/logger.dart';
//
// class ServerHandler {
//   late final http.Client _client;
//   late final String _baseUrl;
//   late final String _callPath;
//   late final String _token;
//   final MyLogger _logger = locator<MyLogger>();
//
//   void _loadEnv() {
//     _baseUrl = dotenv.get('URL');
//     _callPath = dotenv.get('CALL_PATH');
//     _token = dotenv.get('TOKEN');
//   }
//
//   ServerHandler() {
//     _client = http.Client();
//     _loadEnv();
//     // _dio.options.baseUrl = _baseUrl;
//     // _dio.options.headers = {
//     //   'Authorization': 'Bearer $_token',
//     // };
//   }
//
//   Future<GetAllTasksResponse> getTasksList() async {
//     try {
//       final response =
//           await _client.get(Uri.https(_baseUrl, _callPath), headers: {
//         'Authorization': 'Bearer $_token',
//         "Access-Control-Allow-Origin": "*",
//         'Content-Type': 'application/json',
//         'Accept': '*/*',
//       });
//       final data = response.body;
//       _logger.i('GOT DATA FROM SERVER:'
//           '$data');
//       return GetAllTasksResponse.fromJson(jsonDecode(data));
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 400) {
//         throw WrongResponseError;
//       } else if (e.response?.statusCode == 401) {
//         throw AuthError;
//       } else if (e.response?.statusCode == 404) {
//         throw TaskNotExistsError;
//       } else {
//         _logger.e(e.response?.statusCode);
//         throw OtherError;
//       }
//     }
//   }
//
//   patchTasksList({
//     required int revision,
//     required List<GlobalTask> list,
//   }) async {
//     try {
//       var listForSending = PatchAllTasksResponse(list).toJson();
//       _logger.i('Data for patching:'
//           '$listForSending, \n revision: ${revision - 1}');
//       final response = await _client.patch(
//         Uri.http(_baseUrl, _callPath),
//         body: jsonEncode(listForSending),
//         headers: {
//           'X-Last-Known-Revision': (revision - 1).toString(),
//           'Authorization': 'Bearer $_token',
//           "Access-Control-Allow-Origin": "*",
//           'Content-Type': 'application/json',
//           'Accept': '*/*',
//         },
//       );
//       final data = response.body;
//       _logger.i('RESPONSE AFTER PATCHING:'
//           '$data');
//       return GetAllTasksResponse.fromJson(jsonDecode(data));
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 400) {
//         throw WrongResponseError;
//       } else if (e.response?.statusCode == 401) {
//         throw AuthError;
//       } else if (e.response?.statusCode == 404) {
//         throw TaskNotExistsError;
//       } else {
//         throw OtherError;
//       }
//     }
//   }
// }

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
