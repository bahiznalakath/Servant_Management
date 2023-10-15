import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServantDetailsPage extends StatefulWidget {
  const ServantDetailsPage({Key? key}) : super(key: key);

  @override
  _ServantDetailsPageState createState() => _ServantDetailsPageState();
}

class _ServantDetailsPageState extends State<ServantDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String jobType = '';
  int experience = 0; // Changed experience to an integer.

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Servant Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xffe76f86),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe76f86), Color(0xffd3bde5)],
          ),
        ),
        child: ListView( // Use ListView instead of Form and ListTile
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      child: Icon(
                        Icons.person,
                        size: 45,
                      ),
                    ),

                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Job Type: ${jobType}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Experience: ${experience} years',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // // Navigate to the editing page.
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditServantPage(), // Pass the necessary data to the editing page.
                //   ),
                // );
              },
              child: const Text('Edit Details'),
            ),
          ],
        ),
      ),
    );
  }

  _fetchUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('servants')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          email = ds.data()?['email'] ?? '';
          username = ds.data()?['userName'] ?? '';
          jobType = ds.data()?['jobType'] ?? '';
          experience = ds.data()?['experience'] ?? 0;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
