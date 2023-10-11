import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:servantmanagement/UI/servant/accept_reject_screen.dart";
import "package:servantmanagement/UI/user/category_screen.dart";
import "../Login.dart";
import "admin/manage_servants_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Determine the user type based on some logic, and then call _navigateToNextScreen.
    // String userType = determineUserType(); // Replace determineUserType() with your logic.
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    await Future.delayed(const Duration(seconds: 3));

    String? userType = user != null
        ? 'user'
        : null; // Replace with your logic to determine the user type

    if (userType != null) {
      switch (userType) {
        case 'user':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CategoriesList()));
          break;
        case 'servant':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AcceptRejectPage()));
          break;
        case 'admin':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminDashboard()));
          break;
        default:
          // Handle the situation as needed when userType is not recognized.
          break;
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  // void _navigateToNextScreen() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   if (user != null) {
  //     // User is logged in, navigate to the home screen.
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const CategoriesList(),
  //       ),
  //     );
  //   } else {
  //     // User is not logged in, navigate to the login screen.
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const LoginPage(),
  //       ),
  //     );
  //   }
  // }

  // void _navigateToNextScreen(String userType) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   if (user != null) {
  //     // User is logged in, navigate to the appropriate home screen.
  //     if (userType == 'user') {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const CategoriesList(),
  //         ),
  //       );
  //     } else if (userType == 'servant') {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => const AcceptRejectPage(),
  //         ),
  //       );
  //     }
  //   } else {
  //     // User is not logged in, stay on the MainLogin page.
  //     // You can display a message or handle this case as needed.
  //         // User is not logged in, navigate to the login screen.
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //             builder: (context) => const LoginPage(),
  //           ),
  //         );
  //   }
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

  String determineUserType() {
    // Implement your logic here to determine the user type.
    // You can use any criteria or user interaction you want.

    // For example, you can check some state or variable in your app.
    // Assuming you have a boolean variable isUserSelected, you can do something like this:

    bool isUserSelected = true; // Set this based on user interaction.

    if (isUserSelected) {
      return 'user';
    } else {
      return 'servant';
    }
  }
}
