import 'package:dio/dio.dart';

class DioHelper {
  final dio = Dio();

  void configureDio() {
    dio.options.baseUrl = 'https://api.pub.dev';
  }