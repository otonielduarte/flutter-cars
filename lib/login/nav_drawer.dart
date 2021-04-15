import 'package:cars/login/login_page.dart';
import 'package:cars/login/user.dart';
import 'package:cars/shared/util/nav.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _header(),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favorites"),
              subtitle: Text("Click to see your favorites"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              subtitle: Text("We will to help you"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
              onTap: () => _handleLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _header() {
    Future<User?> future = User.get();
    return FutureBuilder<User?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        User? user = snapshot.data;
        return user != null
            ? UserAccountsDrawerHeader(
                accountName: Text(user.name),
                accountEmail: Text(user.email),
                currentAccountPicture:
                    CircleAvatar(backgroundImage: NetworkImage(user.urlFoto)),
              )
            : Container();
      },
    );
  }

  void _handleLogout(BuildContext context) {
    User.clear();
    push(
      context,
      LoginPage(),
      replace: true,
    );
  }
}
