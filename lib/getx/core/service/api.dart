import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valet_parking_app/shared/widgets/app_toast.dart';
import '../../config.dart';
import '../../shared/utils/screen_util.dart';
import 'api_response.dart';
import 'urls.dart';


enum Method { get, post, put, patch, delete }

class Api {
  static Future<ApiResponse> call({
    required String endPoint,
    Method method = Method.get,
    Object? body,
    bool isShowLoader = false,
    bool isShowToast = true,
    String? fetchKeyName,
  }) async {
    try {
      final headers =accessToken!=null? {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken",
        "platform": "app"
      }:{
        'Content-Type': 'application/json',
      
        "platform": "app"
      };

      if (isShowLoader) {
        isShowingLoader = true;
        showLoader();
      }

      final http.Response response;
      Uri url = Uri.parse("$baseUrl$endPoint");
      debugPrint('$headers');
      debugPrint('$url');

      if (body != null && method == Method.get) {
        method = Method.post;
      }

      //REST API METHOD
      switch (method) {
        case Method.get:
          response = await http.get(url, headers: headers);
          break;
        case Method.post:
          response =
              await http.post(url, body: json.encode(body), headers: headers);
          break;

        case Method.patch:
          response =
              await http.patch(url, body: json.encode(body), headers: headers);
          break;
        case Method.put:
          response =
              await http.put(url, body: json.encode(body), headers: headers);
          break;

        case Method.delete:
          response = await http.delete(url,
              body: body != null ? json.encode(body) : null, headers: headers);
          break;

        default:
          throw ("Invalid request type");
      }

      print("response.............${response.body}");

      if (isShowLoader) hideLoader();
      if (response.statusCode == 401 && accessToken != null) {
        // SharedPref().logout();
        return ApiResponse(
            success: false,
            msg: "",
            data: null,
            statusCode: response.statusCode.toString(),
            response: response);
      }
      // // Check if response body is null or empty
      // if (response.body == null || response.body.isEmpty) {
      //   return ApiResponse(
      //     success: false,
      //     msg: "Empty response from server",
      //     data: null,
      //     statusCode: response.statusCode.toString(),
      //     response: null,
      //   );
      // }
      final Map<String, dynamic> responseData = json.decode(response.body);
     
      return ApiResponse.fromJson(
        url,
        method,
        body,
        responseData,
        response,
        fetchKeyName: fetchKeyName,
      );
    } on SocketException {
      if (isShowLoader) hideLoader();
      showToast("Network seems to be offline");

      return ApiResponse(
          success: false,
          msg: "Network seems to be offline",
          data: null,
          statusCode: "",
          response: null);
    } catch (e) {
      debugPrint(e.toString());

      if (isShowLoader) hideLoader();
      //  if(isShowToast)showToast(e.toString());

      return ApiResponse(
          success: false,
          msg: e.toString(),
          data: null,
          statusCode: "",
          response: null);
    }
  }
}
