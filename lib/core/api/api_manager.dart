import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_constants.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  Dio dio = Dio();

  Future<Response<dynamic>> getData(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? headers}) async {
    var response = await dio.get(
      ApiConstants.baseUrl + endPoint,
      queryParameters: queryParameters,
      options: Options(headers: headers, validateStatus: (status) => true),
    );
    return response;
  }

  Future<Response<dynamic>> postData(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? headers,
      Object? body}) async {
    var response = await dio.post(ApiConstants.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers, validateStatus: (status) => true),
        data: body);
    return response;
  }

  Future<Response<dynamic>> deleteData(
      {required String endPoint,
        Map<String, dynamic>? queryParameters,
        Options? options,
        Map<String, dynamic>? headers,
        Object? body}) async {
    var response = await dio.delete(ApiConstants.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers, validateStatus: (status) => true),
        data: body);
    return response;
  }

  Future<Response<dynamic>> updateData(
      {required String endPoint,
        Map<String, dynamic>? queryParameters,
        Options? options,
        Map<String, dynamic>? headers,
        Object? body}) async {
    var response = await dio.put(ApiConstants.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers, validateStatus: (status) => true),
        data: body);
    return response;
  }
}
