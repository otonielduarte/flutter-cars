import 'package:cars/login/login_api.dart';
import 'package:cars/login/user.dart';
import 'package:cars/shared/generic_bloc.dart';
import 'package:cars/shared/services/api_response.dart';

class LoginBloc extends GenericBloc<bool> {

  Future<ApiResponse<User>> login(String login, String password) async {

    add(true);

    ApiResponse response = await LoginApi.login(login, password) ;

    add(false);

    return response as ApiResponse<User>;

  }
}