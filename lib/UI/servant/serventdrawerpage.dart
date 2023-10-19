import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servantmanagement/UI/servant/view_history_screen.dart';
import '../../Login.dart';
import '../more_about.dart';
import 'History.dart';
import 'manage_profile_screen.dart';

class ServentDrawerPage extends StatefulWidget {
  const ServentDrawerPage({super.key});

  @override
  State<ServentDrawerPage> createState() => _ServentDrawerPageState();
}

class _ServentDrawerPageState extends State<ServentDrawerPage> {
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
              title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 34
              ),),
              onTap: () {
                // Navigate to the settings page.
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_circle,color: Colors.black,),
                title: const Text('Account',style: TextStyle(fontWeight: FontWeight.bold
                ),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServantDetailsPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history,color: Colors.black,), // Add the icon for history
                title: const Text('History of Works',style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () async {
                  Fluttertoast.showToast(msg: "History of your Works");
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>HistoryMainPage(),
                  ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app,color: Colors.black,),
                title: const Text('Exit',style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),   const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout,color: Colors.black,),
                title: const Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  signOut().then((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(), // Replace with your login screen widget
                      ),
                    );
                  });
                },
              ),
            ),
            const SizedBox(
              height: 145,
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
      print('Error signing out: $e');
    }
  }
}
