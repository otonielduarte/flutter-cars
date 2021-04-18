import 'package:cars/car/home_page.dart';
import 'package:cars/login/login_bloc.dart';
import 'package:cars/login/user.dart';
import 'package:cars/shared/services/api_response.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:cars/shared/util/toast.dart';
import 'package:cars/shared/widget/app_button.dart';
import 'package:cars/shared/widget/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        width: 600,
        child: SingleChildScrollView(
          child: _formLogin(),
        ),
      ),
    );
  }

  Form _formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _fields(),
      ),
    );
  }

  List<Widget> _fields() {
    return [
      AppInputText(
          label: "Login",
          hintText: "John Doe",
          obscureText: false,
          controller: _login,
          validator: (value) => _validator(
                value,
                minLength: 3,
              ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress),
      AppInputText(
        label: "Password",
        hintText: "*******",
        obscureText: true,
        controller: _password,
        validator: (value) => _validator(
          value,
          message: "Your password must have 6 characters",
          minLength: 3,
        ),
        keyboardType: TextInputType.number,
      ),
      StreamBuilder<bool>(
          stream: _bloc.stream,
          initialData: false,
          builder: (context, snapshot) {
            return AppButton(
              "Login",
              onPressed: _handleLogin,
              isLoading: snapshot.data ?? true,
            );
          }),
    ];
  }

  _handleLogin() async {
    if (!_formKey.currentState!.validate()) return null;
    final Map formValues = {'login': _login.text, 'password': _password.text};

    final ApiResponse response = await _bloc.login(
      formValues['login'],
      formValues['password'],
    );

    if (response.ok) {
      User user = response.result;
      user.saveToPrefs();
      push(context, HomePage(), replace: true);
    } else {
      showToast(response.msg);
    }
  }

  _validator(
    String value, {
    int minLength = 0,
    String message = "Please enter some text",
  }) {
    return (value.isEmpty || minLength > value.length) ? message : null;
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
