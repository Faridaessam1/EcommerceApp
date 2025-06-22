import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_constants.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiNetwork {
  final dio = Dio();

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.get(ApiConstants.baseUrl + endPoint,
        queryParameters: queryParameters, options: options);
  }

  Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    return dio.post(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: headers,
      ),
      data: data,
    );
  }

  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    return dio.delete(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: headers,
      ),
      data: data,
    );
  }

  Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    return dio.put(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: headers,
      ),
      data: data,
    );
  }
}
