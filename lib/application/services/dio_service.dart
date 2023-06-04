import 'package:dio/dio.dart';

import '../../../flavors.dart';
import '../../infrastructure/apis/api_interceptor.dart';

class DioService {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: F.variables['maksimaURL'] as String,
        connectTimeout: 60000,
      ),
    );

    dio.interceptors.add(ApiInterceptor());

    return dio;
  }
}
