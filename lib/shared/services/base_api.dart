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

  Client get client => HttpClientWithInterceptor.build(
        requestTimeout: Duration(seconds: 15),
        interceptors: [
          LoggingInterceptor(),
        ],
      );

  Future<Response> apiGet(String url, Map<String, String> headers) async {
    final Uri endpoint = Uri.parse(url);

    return client.get(
      endpoint,
      headers: headers,
    );
  }

  Future<ApiResponse<dynamic>> post(
      String url, Map<String, String> headers, dynamic body) async {
    final Uri endpoint = Uri.parse(url);

    Response response = await client.post(
      endpoint,
      headers: headers,
      body: jsonEncode(body),
    );

    Map<dynamic, dynamic> jsonMap = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.ok(jsonMap);
    }
    return ApiResponse.error(jsonMap['error']);
  }
}

const String baseUrlV1 = 'https://carros-springboot.herokuapp.com/api/v1';
const String baseUrlV2 = "https://carros-springboot.herokuapp.com/api/v2";
