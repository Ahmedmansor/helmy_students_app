import 'package:dio/dio.dart';

import 'end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl, connectTimeout: const Duration(seconds: 60)),
    );
  }
}
