import 'package:cars/models/user.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final User user;

  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name}'),
      ),
      body: Center(
        child: Container(
          child: Text(user.name),
        ),
      ),
    );
  }
}
