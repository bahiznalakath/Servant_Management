import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servantmanagement/UI/servant/accept_reject_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_screen.dart';

class ServantLogin extends StatefulWidget {
  const ServantLogin({Key? key}) : super(key: key);

  @override
  _ServantLoginState createState() => _ServantLoginState();
}

class _ServantLoginState extends State<ServantLogin> {
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
            child:Text(
              'Servant Login\nStart Your Work',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )

          ),
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
                          onSaved: (value) {
                            emailTextController.text = value!;
                          },
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
                          onSaved: (value) {
                            passwordTextController.text = value!;
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
                              onPressed:(){
                                signInWithFirebase();},
                                // FirebaseAuth.instance
                                //     .signInWithEmailAndPassword(
                                //     email: emailTextController.text,
                                //     password: passwordTextController.text)
                                //     .then((value) {
                                //   Fluttertoast.showToast(msg: "Login Successful ");
                                //   print("Log In successfully");
                                //   Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>const AcceptRejectPage()));
                                // }).catchError((e) {
                                //   Fluttertoast.showToast(msg: e!.message);
                                // });
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor:
                                const Color(0xffB81736),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account yet ?"),
                            TextButton(
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const ServantRegisterPage()), // Replace 'PageTwo' with your second page widget.
                                );
                              },
                              child: const Text(
                                "Create an Account",
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
    void signInWithFirebase() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (userCredential.user != null) {
        print("Servant is logged in: ${userCredential.user!.email}");
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  AcceptRejectPage()),
        );
      } else {
        print("Servant is not logged in.");
      }
    } catch (e) {
      // Handle sign-in errors.
      print("Error: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
