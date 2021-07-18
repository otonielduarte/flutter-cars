import 'package:cars/home/home_page.dart';
import 'package:cars/login/login_page.dart';
import 'package:cars/login/user.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:cars/shared/widget/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() async {
    final future1 = User.get();

    Future delay = Future.delayed(Duration(seconds: 2));

    final values = await Future.wait([future1, delay]);
    _navigate(values[0]);
  }

  _navigate(user) =>
      push(context, user != null ? HomePage() : LoginPage(), replace: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).cardColor,
      child: LoadingComponent(),
    ));
  }
}
