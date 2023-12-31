import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../reusable_widgets/simple.dart';
import 'category_screen.dart';
import 'registration_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffe76f86),
              Color(0xffd3bde5),
            ]),
          ),
          child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Welcome to Our App\nPlease Log In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 170.0),
                        TextFormField(
                          autofocus: false,
                          controller: emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 20),
                            hintText: "Email",
                            labelText: "Enter Email",
                            labelStyle:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.black.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: passwordTextController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 20),
                            hintText: "Password",
                            labelText: "Enter Password",
                            labelStyle:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.black.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color.fromRGBO(196, 135, 198, 1)),
                            )),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(225, 95, 27, 3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: ElevatedButton(
                              onPressed: _login,
                              //     () {
                              //   FirebaseAuth auth = FirebaseAuth.instance;
                              //
                              //   auth.signInWithEmailAndPassword(
                              //     email: emailTextController.text,
                              //     password: passwordTextController.text,
                              //   ).then((userCredential) {
                              //     if (userCredential.user != null) {
                              //       // User is logged in.
                              //       print("User is logged in: ${userCredential.user.email}");
                              //     } else {
                              //       // User is not logged in.
                              //       print("User is not logged in.");
                              //     }
                              //   }).catchError((error) {
                              //     // Handle sign-in errors.
                              //     print("Error: $error");
                              //   }
                              //
                              //   .then((value) {
                              //     Fluttertoast.showToast(msg: "Login Successful ");
                              //     print("Log In successfully");
                              //     Navigator.pushReplacement(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>const CategoriesList()));
                              //   }).catchError((e) {
                              //     Fluttertoast.showToast(msg: e!.message);
                              //   });
                              // },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor: const Color(0xffB81736),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 100,
                          width: 300,
                          child: GestureDetector(
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              _handlegooglebuttonClick();
                              print('Google Sign Successfully');
                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset('assets/images/google.png')),
                          ),
                        ),
                        const SizedBox(height: 80.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Don't have an account yet ?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserRegisterPage()), // Replace 'PageTwo' with your second page widget.
                                );
                              },
                              child: const Text(
                                "Create Account",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }

  void _login() async {
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (userCredential.user != Directory.current) {
        print("User is logged in: ${userCredential.user!.email}");
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoriesList()),
        );
      } else {
        print("User is not logged in.");
      }
    } catch (e) {
      // Handle sign-in errors.
      print("Error: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  _handlegooglebuttonClick() {
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      Navigator.pop(context);

      if (user != null) {
        print('User:${user.user}');
        print('UserAdditionalInfo: ${user.additionalUserInfo}');
        print("Login successful with google");

        if (await APIs.userExists()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const CategoriesList()),
          );
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CategoriesList()),
            );
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('_signInWithGoogle : $e' as String);
      Dialogs.showSnackbar(context, "Something Went Wrong (Check Internet !)");
      return null;
    }
  }
}
