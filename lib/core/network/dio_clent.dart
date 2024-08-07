import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal();

  Dio createDio() {
    return Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8000',
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      
    ));
  }
}
