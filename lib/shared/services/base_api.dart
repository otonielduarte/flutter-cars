import 'dart:convert';

import 'package:cars/login/user.dart';
import 'package:cars/shared/services/api_response.dart';
import 'package:cars/shared/services/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

abstract class BaseApi {
  getHeader() async {
    User user = await User.get();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };
    return headers;
  }

  Client _client = HttpClientWithInterceptor.build(
    requestTimeout: Duration(seconds: 15),
    interceptors: [
      LoggingInterceptor(),
    ],
  );

  Future apiGet(String url, Map<String, String> headers) async {
    return _client.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  Future<ApiResponse> put(
    String url,
    Map<String, String> headers,
    dynamic body,
  ) async {
    try {
      Response response = await _client.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      Map<dynamic, dynamic> jsonMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.ok(jsonMap);
      }
      return ApiResponse.error(jsonMap['error']);
    } catch (e) {
      return ApiResponse.error("Algo deu errado tente novamente mais tarde");
    }
  }

  Future<ApiResponse> delete(String url, Map<String, String> headers) async {
    try {
      Response response = await _client.delete(
        Uri.parse(url),
        headers: headers,
      );

      Map<dynamic, dynamic> jsonMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.ok(jsonMap['msg']);
      }
      return ApiResponse.error(jsonMap['error']);
    } on Exception catch (e) {
      print('error >>>>>>>>>>>>>> $e');
      return ApiResponse.error("Algo deu errado tente novamente mais tarde");
    }
  }

  Future<ApiResponse> post(
    String url,
    Map<String, String> headers,
    dynamic body,
  ) async {
    try {
      Response response = await _client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      Map<dynamic, dynamic> jsonMap = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return ApiResponse.ok(jsonMap);
      }
      return ApiResponse.error(jsonMap['error']);
    } on Exception catch (e) {
      print('error >>>>>>>>>>>>>> $e');
      return ApiResponse.error("Algo deu errado tente novamente mais tarde");
    }
  }
}

const String baseUrlV1 = 'https://carros-springboot.herokuapp.com/api/v1';
const String baseUrlV2 = "https://carros-springboot.herokuapp.com/api/v2";
