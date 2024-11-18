import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = "http://127.0.0.1:8080/";

  final Dio dio = Dio(
    BaseOptions(baseUrl: _baseUrl)
  );

  DioClient() {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}