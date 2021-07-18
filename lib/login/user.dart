import 'dart:convert';

import 'package:cars/shared/util/prefs.dart';

class User {
  final int id;
  final String login;
  final String name;
  final String email;
  final String urlFoto;
  final String token;
  final List<String> roles;

  User(this.id, this.login, this.name, this.email, this.token, this.roles,
      this.urlFoto);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        login = json['login'],
        name = json['nome'],
        email = json['email'],
        token = json['token'],
        urlFoto = json['urlFoto'],
        roles = json['roles'].cast<String>();

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'login': this.login,
        'nome': this.name,
        'email': this.email,
        'urlFoto': this.urlFoto,
        'token': this.token,
        'roles': this.roles,
      };

  static clear() {
    Prefs.setString('user.info', '');
  }

  saveToPrefs() {
    Prefs.setString('user.info', jsonEncode(toJson()));
  }

  static Future<User?> get() async {
    String json = await Prefs.getString('user.info');
    if (json == '') return null;
    return User.fromJson(jsonDecode(json));
  }
}
