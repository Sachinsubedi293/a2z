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
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
    ));
  }
}
