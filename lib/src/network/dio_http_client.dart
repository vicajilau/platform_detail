import 'package:dio/dio.dart';

/// Dio client for network requests
class DioClient {
  /// Dio instance
  final Dio _dio;

  /// Constructor for DioClient
  DioClient({Dio? dio}) : _dio = dio ?? Dio();

  /// Get Dio instance
  Dio getDio() {
    return _dio;
  }
}
