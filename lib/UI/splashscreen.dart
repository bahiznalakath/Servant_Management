import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servantmanagement/UI/servant/accept_reject_screen.dart';
import 'package:servantmanagement/UI/user/category_screen.dart';
import 'admin/AdminDashboard.dart';
import 'admin/manage_servants_screen.dart';
import '../Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final auth = FirebaseAuth.instance;
      auth.authStateChanges().listen((user) {
        if (user == null) {
          // User not logged in
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
          );
        } else {
          // User is logged in
          user.getIdTokenResult().then((tokenResult) {
            final claims = tokenResult.claims;
            final role = claims?['role'];

            if (role == 'admin') {
              // User is an admin
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AdminDashboard()),
                    (route) => false,
              );
            } else if (role == 'servant') {
              // User is a servant
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AcceptRejectPage()),
                    (route) => false,
              );
            } else {
              // User is a regular user
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => CategoriesList()),
                    (route) => false,
              );
            }
          });
        }
      });
    });
  }

  // void initState() {
  //   super.initState();
  //
  //   Future.delayed(const Duration(seconds: 3), () async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var type = prefs.getString('type');
  //     print(type);
  //     if (type != null) {
  //       switch (type) {
  //         case 'users':
  //           Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(
  //               builder: (context) => CategoriesList(),
  //             ),
  //           );
  //           break;
  //         case 'servant':
  //           Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(
  //               builder: (context) => AcceptRejectPage(),
  //             ),
  //           );
  //           break;
  //         case 'admin':
  //           Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(
  //               builder: (context) => AdminDashboard(),
  //             ),
  //           );
  //           break;
  //         default:
  //         // The user's type is invalid. Navigate to the LoginPage screen.
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  //           break;
  //       }
  //     } else {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 54,
              backgroundImage: AssetImage("assets/images/log.jpg"),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Welcome to ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Servant Booking App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            SpinKitFadingCircle(
              color: Colors.black,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
