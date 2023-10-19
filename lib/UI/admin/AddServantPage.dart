import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Firebase/Model/servant_model.dart';
import 'AdminDashboard.dart';

class AddServantPage extends StatefulWidget {
  @override
  _AddServantPageState createState() => _AddServantPageState();
}

class _AddServantPageState extends State<AddServantPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedJobType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new servant here',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffe76f86),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
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
                      controller: userNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'username',
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'email',
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
                      // decoration: InputDecoration(labelText: ''),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Experience',
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
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
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
                    child: DropdownButtonFormField<String>(
                      value: _selectedJobType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedJobType = newValue;
                        });
                      },
                      items: ServantModel.jobTypes.map((jobType) {
                        return DropdownMenuItem<String>(
                          value: jobType,
                          child: Text(jobType),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Job Type',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a job type';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('servants').add({
                        'userName': userNameController.text,
                        'email': _emailController.text,
                        'experience': experienceController.text,
                        'password': passwordController.text,
                        'jobType': _selectedJobType,
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New servant added successfully.'),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  AdminDashboard()),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error adding servant: $error'),
                          ),
                        );
                      });
                    },
                    child: Text('Add Servant',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
