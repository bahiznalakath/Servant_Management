import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmedBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('confirmed_orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Data is ready, display it
          final data = snapshot.data!.docs;

          // You can now loop through 'data' to display individual records
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final document = data[index];
              final orderId = document['orderId'];
              final servantName = document['servantName'];
              final userName = document['userName'];
              final jobType = document['jobType'];

              return Card(
                elevation: 20,
                child: ListTile(
                  title: Text('Order ID: $orderId'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Colors.black,),
                      Text('Servant Name: $servantName'),
                      Text('User Name: $userName'),
                      Text('Job Type: $jobType'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
