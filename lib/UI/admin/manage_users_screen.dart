import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final userList = snapshot.data!.docs;
        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            final userData = userList[index].data() as Map<String, dynamic>;
            final userName = userData['userName'];
            final userEmail = userData['email'];
            final password = userData['password'];

            return Card(
              elevation: 20,
              child: Column(
                children: [
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text('username :${userName}'),
                    subtitle: Text(' Email :${userEmail} \n Password : ${password}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userList[index].id)
                            .delete();
                        Fluttertoast.showToast(msg: " User ${userName}deleted Successful ");
                      },
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
