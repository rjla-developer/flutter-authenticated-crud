import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: Duration(microseconds: 5000),
        receiveTimeout: Duration(microseconds: 3000),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Dio get dio => _dio;
}
