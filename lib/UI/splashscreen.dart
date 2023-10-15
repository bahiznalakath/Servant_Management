import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:servantmanagement/UI/servant/accept_reject_screen.dart';
import 'package:servantmanagement/UI/user/category_screen.dart';
import 'admin/AdminDashboard.dart';
import 'admin/manage_servants_screen.dart';
import '../Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    await Future.delayed(const Duration(seconds: 3));

    if (user == null) {
      // User is not logged in, navigate to the login page.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      String userType = await getUserTypeFromDatabase(user);

      if (userType == 'user') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CategoriesList(),
          ),
        );
      } else if (userType == 'servant') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AcceptRejectPage(),
          ),
        );
      } else if (userType == 'admin') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AdminDashboard(),
          ),
        );
      } else {
        // Handle other user types or show an appropriate message.
        // You may navigate to a default page or display an error message.
        // For example:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    }
  }

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

  Future<String> getUserTypeFromDatabase(User user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference userRef = firestore.collection('users').doc(user.uid);

    try {
      DocumentSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('userType')) {
          String userType = userData['userType'];
          return userType;
        } else {
          return 'unknown'; // Handle the case where the 'userType' field does not exist.
        }
      } else {
        return 'unknown'; // Handle the case where the user document does not exist.
      }
    } catch (e) {
      print("Error retrieving user type: $e");
      return 'unknown'; // Handle errors appropriately.
    }
  }
}
