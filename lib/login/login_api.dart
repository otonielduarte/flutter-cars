import 'dart:async';

import 'package:cars/login/user.dart';
import 'package:cars/shared/services/api_response.dart';
import 'package:cars/shared/services/base_api.dart';

class LoginApi extends BaseApi {
  Future<ApiResponse<User>> login(String login, String password) async {
    try {
      final String urlLogin = "$baseUrlV2/login";

      Map params = {
        'username': login,
        'password': password,
      };

      Map<String, String> headers = {"Content-type": "application/json"};

      final response = await post(urlLogin, headers, params);

      if (response.ok) {
        final User user = User.fromJson(response.result);
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(response.msg);
    } catch (error, exception) {
      print('Unexpected error $error > $exception');

      if (error is TimeoutException) {
        return ApiResponse.error("TimeoutException after 0:00:05");
      }

      return ApiResponse.error("Unexpected error");
    }
  }
}
