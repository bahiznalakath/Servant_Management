import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServantDetailsPage extends StatelessWidget {
  const ServantDetailsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servant Details'),
        centerTitle: true,
        backgroundColor:  const Color(0xffe76f86),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('servants').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return const Text('No data available');
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final userData = snapshot.data!.docs[index].data() as Map<
                    String,
                    dynamic>;
                final username = userData['userName'] ?? 'N/A';
                final email = userData['email'] ?? 'N/A';
                final jobType = userData['jobType'] ?? 'N/A';
                final experience = userData['experience'] ?? 'N/A';

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ Center(
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
                              ' $username',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email: $email',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Job Type: $jobType',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Experience: $experience years',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to the editing page with the selected document ID
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditServantPage(
                                documentId: snapshot.data!.docs[index].id,
                                userData: userData,
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),

    );
  }
}

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
    // Initialize the text controllers with existing data
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
                onPressed: () {
                  // Update the Firestore document with the new data
                  FirebaseFirestore.instance.collection('servantS').doc(
                      widget.documentId).update({
                    'userName': usernameController.text,
                    'email': emailController.text,
                    'jobType': jobTypeController.text,
                    'experience': int.tryParse(experienceController.text),
                  });

                  Navigator.pop(context); // Return to the previous page
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
