import 'package:cars/pages/login_page.dart';
import 'package:cars/util/nav.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Otoniel"),
              accountEmail: Text("otonielduarte2@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://carismartes.com.br/assets/global/images/avatars/avatar1_big.png"),
              ),
            ),
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

  void _handleLogout(BuildContext context) {
    push(
      context,
      LoginPage(),
      replace: true,
    );
  }
}
