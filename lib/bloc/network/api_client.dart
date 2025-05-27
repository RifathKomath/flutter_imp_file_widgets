import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'urls.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  final defaultHeader = {
    'Content-Type': 'application/json',
  };

  Future<dynamic> post({
    required String path,
    bool? nobaseUrl,
    bool isbytes=false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      debugPrint("body............${data.toString()}");
      final headr = headers ?? defaultHeader;
      debugPrint("header............${headr.toString()}");
    

      // Convert to FormData if isFormData is true
      dynamic requestData = data;
      if (isFormData && data != null) {
        requestData = FormData.fromMap(data);
      }
      final apiPath = nobaseUrl == true ? path : "$baseUrl$path";
        debugPrint("url ...........$apiPath");

      final response = await _dio.post(
        apiPath,
        data: requestData,
        options: Options(
          headers: headr,
          responseType:isbytes?ResponseType.bytes: ResponseType.json,
          contentType: isFormData
              ? Headers.multipartFormDataContentType
              : Headers.jsonContentType,
        ),
      );

      debugPrint("response.......${response.toString()}");

      return response.data;
    }
     on DioException
      catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<dynamic> get({
  required String path,
  Map<String, dynamic>? queryParams,
  bool responseType = false, // Add this parameter to indicate binary response
}) async {
  try {
    debugPrint("GET queryParams............${queryParams.toString()}");
    debugPrint("GET header............${defaultHeader.toString()}");
    debugPrint("url ...........$baseUrl$path");

    final response = await _dio.get(
      "$baseUrl$path",
      queryParameters: queryParams,
      options: Options(
        headers: defaultHeader,
        responseType: responseType ? ResponseType.bytes : ResponseType.json, // Set response type based on the parameter
      ),
    );

    debugPrint("GET response type.......${response.data.runtimeType}");

    return response.data;
  } on DioException catch (e) {
    throw Exception('Network error: ${e.message}');
  }
}

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      debugPrint("PUT body............${data.toString()}");
      final headr = headers ?? defaultHeader;
      debugPrint("PUT header............${headr.toString()}");
      debugPrint("PUT url ...........$baseUrl$path");

      // Convert to FormData if isFormData is true
      dynamic requestData = data;
      if (isFormData && data != null) {
        requestData = FormData.fromMap(data);
      }

      final response = await _dio.put(
        "$baseUrl$path",
        data: requestData,
        options: Options(
          headers: headr,
          contentType: isFormData
              ? Headers.multipartFormDataContentType
              : Headers.jsonContentType,
        ),
      );

      debugPrint("PUT response.......${response.toString()}");

      return response.data;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
