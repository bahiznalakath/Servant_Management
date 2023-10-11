import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servantmanagement/UI/user/login_screen.dart';

import 'User_Cart.dart';
import 'manage_profile_screen.dart';
import '../more_about.dart';

class UserDrawerPage extends StatefulWidget {
  const UserDrawerPage({super.key});

  @override
  State<UserDrawerPage> createState() => _UserDrawerPageState();
}

class _UserDrawerPageState extends State<UserDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffe76f86),
              Color(0xffd3bde5),
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 25,
              ),
              title: const Text(
                'Account',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailsPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_cart,
                size: 25,
              ),
              title: const Text(
                'My Cart',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CartPage(selectedWorkers: [],),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                size: 25,
              ),
              // Add the icon for history
              title: const Text(
                'History of Orders',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                size: 25,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 25,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                signOut().then((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const UserLogin(), // Replace with your login screen widget
                    ),
                  );
                });
              },
            ),
            const SizedBox(
              height: 175,
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyDialog();
                  },
                );
              },
              child: const Text('More about'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }
}
