import 'dart:async';
import 'dart:convert';

import 'package:cars/models/user.dart';
import 'package:cars/services/api_response.dart';
import 'package:cars/services/base_api.dart';

const String baseUrl = "http://livrowebservices.com.br/rest";

/*
 * 
 * usuario: admin
 * senha: 123
 * 
 */

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String password) async {
    try {
      final Uri urlLogin = Uri.parse("$baseUrlV2/login");

      /* 
    // TO V1
    Map params = {
      'login': login,
      'senha': password,
    }; */

      // TO V2
      Map params = {
        'username': login,
        'password': password,
      };

      Map<String, String> headers = {"Content-type": "application/json"};

      final response = await baseClient.post(
        urlLogin,
        headers: headers,
        body: json.encode(params),
      );

      final mapResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final User user = User.fromJson(mapResponse);
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      print('Unexpected error $error > $exception');

      if (error is TimeoutException) {
        return ApiResponse.error("TimeoutException after 0:00:05");
      }

      return ApiResponse.error("Unexpected error");
    }
  }
}
