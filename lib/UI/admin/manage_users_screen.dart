import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe76f86),
      ),
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

            return ListTile(
              title: Text(userName),
              subtitle: Text(userEmail),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userList[index].id)
                      .delete();
                },
              ),
            );
          },
        );
      },
    );
  }
}
