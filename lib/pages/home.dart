import 'package:cars/models/user.dart';
import 'package:cars/util/nav_drawer.dart';
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
      body: _body(),
      drawer: NavigationDrawer(),
    );
  }

  Center _body() {
    return Center(
      child: Container(
        child: Text(user.name),
      ),
    );
  }
}
