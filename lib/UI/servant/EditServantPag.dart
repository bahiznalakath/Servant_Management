import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditServantPage extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> userData;

  const EditServantPage({super.key, required this.documentId, required this.userData});

  @override
  _EditServantPageState createState() => _EditServantPageState();
}

class _EditServantPageState extends State<EditServantPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.userData['userName'] ?? '';
    emailController.text = widget.userData['email'] ?? '';
    jobTypeController.text = widget.userData['jobType'] ?? '';
    experienceController.text = widget.userData['experience'] != null
        ? widget.userData['experience'].toString()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Servant',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor:   const Color(0xffe76f86),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        labelText: 'Username',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: jobTypeController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Job Type',
                        labelText: 'Job Type',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: experienceController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Experience (years)',
                        labelText: 'Experience (years)',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final firebaseUser = FirebaseAuth.instance.currentUser;
                    final userDoc = await FirebaseFirestore.instance.collection('servants').doc(firebaseUser?.uid).get();

                    if (userDoc.exists) {
                      await userDoc.reference.update({
                        'userName': usernameController.text,
                        'email': emailController.text,
                        'jobType': jobTypeController.text,
                        'experience': int.tryParse(experienceController.text),
                      });

                      setState(() {
                        // Update any state variables if necessary
                      });

                      Navigator.pop(context); // Return to the previous page
                    } else {
                      print('User document does not exist.');
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: const Text('Save Changes'),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
