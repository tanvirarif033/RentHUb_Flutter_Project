import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/about_us_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/logout_screen.dart';

import 'account_screen.dart';
import 'addAcoount_screen.dart';
import 'invite_friends_screen.dart';
import 'privacy_screen.dart';
import 'setting_screen.dart';
import 'update_screen.dart';
import 'userPage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const name = 'ARIF33';
    const email = 'arif33@gmail.com';
    const urlImage =
        'https://tse1.mm.bing.net/th?id=OIP.wEsBe2udHBieFeZVmus8qAHaHk&pid=Api&rs=1&c=1&qlt=95&w=119&h=121';

    return Drawer(
      child: Material(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserPage(
                    name: 'Arif33',
                    urlImage: urlImage,
                  ),
                ),
              ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Account',
                    icon: Icons.account_circle_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Add Account',
                    icon: Icons.add_circle_outline_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Privacy',
                    icon: Icons.privacy_tip_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Updates',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Log Out',
                    icon: Icons.logout_outlined,
                    onClicked: () => showLogoutDialog(context),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'About Us',
                    icon: Icons.co_present_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Invite Friends',
                    icon: Icons.person_add_alt_1_outlined,
                    onClicked: () => selectedItem(context, 7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.add_a_photo_outlined, color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const account_screen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const addAccount_screen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const privacy_screen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const update_screen(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const setting_screen(),
        ));
        break;
      case 5:
      // Log Out
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const about_us_screen(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const invite_friends_screen(),
        ));
        break;

      default:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const account_screen(),
        ));
        break;
    }
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await _auth.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }
}
