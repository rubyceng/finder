import 'package:dio/dio.dart';
import 'package:finder/app/config.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  late final Dio dio;

  DioClient._internal() {
    final options = BaseOptions(
      baseUrl: Config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    // 拦截器
    dio.interceptors.addAll([
      // 日志
      LogInterceptor(requestBody: true, responseBody: true),
      // // 自定义
      // AuthInterceptor(),
      // ErrorInterceptor(),
    ]);
  }
}
