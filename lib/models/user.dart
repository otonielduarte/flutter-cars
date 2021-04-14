class User {
  final String login;
  final String name;
  final String email;
  final String urlFoto;
  final String token;
  final List<String> roles;

  User(this.login, this.name, this.email, this.token, this.roles, this.urlFoto);

  User.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        name = json['nome'],
        email = json['email'],
        token = json['token'],
        urlFoto = json['urlFoto'],
        roles = json['roles'] != null
            ? json['roles'].map<String>((role) => role.toString()).toList()
            : [];
}
