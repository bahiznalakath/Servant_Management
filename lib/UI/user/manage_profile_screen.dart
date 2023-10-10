import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController _usernameController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffe76f86),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffe76f86),
            Color(0xffd3bde5),
          ]),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person,size: 45,),
                ),
              ),
              const SizedBox(height: 20,),
              StreamBuilder<QuerySnapshot>(
                // Replace 'users' with your actual Firestore collection name
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<Widget> userDataWidgets = [];
                  final users = snapshot.data!.docs;
                  for (var user in users) {
                    final userData = user.data() as Map<String, dynamic>;
                    final username = userData['userName'];
                    final email = userData['email'];
                    userDataWidgets.add(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          _isEditing
                              ? TextFormField(
                                  controller: _usernameController,
                                )
                              : Text(
                                  'Username: $username',
                                  style: const TextStyle(fontSize: 20),
                                ),
                          const SizedBox(height: 15,),
                          Text('Email: $email',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 20,width: 20,),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userDataWidgets,
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!_isEditing)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    ),
                  if (_isEditing)
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        // Update the Firestorm document with the new username
                        final newUsername = _usernameController.text;
                        // Add Firestore update logic here
                        // For example:
                        // FirebaseFirestore.instance.collection('users').doc(userId).update({'userName': newUsername});

                        setState(() {
                          _isEditing = false;
                        });
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
