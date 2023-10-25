import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../servant/EditServantPag.dart';
import 'AddServantPage.dart';

class ServantManagementPage extends StatefulWidget {
  @override
  _ServantManagementPageState createState() => _ServantManagementPageState();
}

class _ServantManagementPageState extends State<ServantManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('servants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching data.
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Text(
                'No data available'); // Handle the case where there's no data.
          }

          var servantDocuments = snapshot.data!.docs;
          var totalServants = servantDocuments.length;

          // Assuming you want to display details of all servants in a ListView
          return ListView.builder(
            itemCount: totalServants,
            itemBuilder: (context, index) {
              var servant = servantDocuments[index].data();

              return Card(
                elevation: 20, // Adjust the elevation for a shadow effect
                margin: EdgeInsets.all(8), // Add margin to the Card
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  // Add padding to ListTile content
                  title: Text(
                    servant['jobType'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Adjust the font size
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Text('Username: ${servant['userName']}'),
                      Text('Email: ${servant['email']}'),
                      Text('Experience: ${servant['experience']}'),
                      Text('Password: ${servant['password']}'),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('servants')
                              .doc(servantDocuments[index].id)
                              .delete()
                              .then((value) {
                            Fluttertoast.showToast(
                                msg:
                                    "User ${servant['userName']} deleted successfully");
                          }).catchError((error) {
                            Fluttertoast.showToast(
                                msg: "Error deleting user: $error");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Servant page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddServantPage(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
