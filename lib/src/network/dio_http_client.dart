import 'package:dio/dio.dart';

class DioClient {
  static DioClient? _instance;
  static final Dio _dio = Dio();

  factory DioClient() => _instance ?? DioClient._internal();

  DioClient._internal() {
    _instance = this;
  }

  /// Get Dio instance
  Dio getDio() {
    return _dio;
  }
}
