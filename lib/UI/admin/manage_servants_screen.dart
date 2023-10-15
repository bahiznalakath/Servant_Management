import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServantManagementPage extends StatefulWidget {
  @override
  _ServantManagementPageState createState() => _ServantManagementPageState();
}

class _ServantManagementPageState extends State<ServantManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Servants',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe76f86),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('servants').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching data.
          }

          var servantDocuments = snapshot.data!.docs;
          var totalServants = servantDocuments.length;

          // Assuming you want to display details of all servants in a ListView
          return ListView.builder(
            itemCount: totalServants,
            itemBuilder: (context, index) {
              var servant = servantDocuments[index]
                  .data(); // Get all fields of the servant
              return Card(
                child: ListTile(
                  title: Text(servant['userName']),
                  subtitle: Text(servant['jobType']),
                  trailing: Text('Experience: ${servant['experience']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
