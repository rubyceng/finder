import 'package:dio/dio.dart';
import 'package:finder/utils/net/dio.dart';

class Api {
  static final Dio _dio = DioClient().dio;

  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) {
    return _dio.get<T>(path, queryParameters: query);
  }

  static Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: query);
  }

  static Future<Response<T>> put<T>(String path, {dynamic data}) {
    return _dio.put<T>(path, data: data);
  }

  static Future<Response<T>> delete<T>(String path, {dynamic data}) {
    return _dio.delete<T>(path, data: data);
  }
}
