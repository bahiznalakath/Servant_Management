import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AdminDashboard.dart';
import 'manage_servants_screen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

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
                  'Admin Login\n You can Manage user and servant',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 130.0),
                        TextFormField(
                          autofocus: false,
                          controller: _userNameTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Panel Code ";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _userNameTextController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 20),
                            labelText: "Enter Panel Code",
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
                          controller: _passwordTextController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required for login";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _passwordTextController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 20),
                            hintText: "Password",
                            labelText: "Admin password",
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
                        const SizedBox(height: 20.0),
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
                              onPressed: () => _signIn(context),
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
                      ],
                    ),
                  ),
                ),
              ))
        ]));
  }

  Future<void> _signIn(BuildContext context) async {
    final panelCode = _userNameTextController.text.trim();
    final password = _passwordTextController.text.trim();

    if (panelCode.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Both Admin Username and Password are required",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    final adminRef = FirebaseFirestore.instance.collection('adminLogin');
    final querySnapshot = await adminRef
        .where('panelCode',
            isEqualTo: panelCode) // Change panelCode to panelCode
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isEmpty) {
      Fluttertoast.showToast(
        msg: "Invalid credentials",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(msg: "Login Admin Successful ");
      SharedPreferences pref = await SharedPreferences.getInstance();
      Navigator.of(context).pushReplacementNamed('/admin_dashboard');
    }
  }
}
