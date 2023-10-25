import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RejectedBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RejectedBookingsList(),
    );
  }
}

class RejectedBookingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('reject_orders').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No rejected orders available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var orderData = snapshot.data!.docs[index].data();

            // You can access order data fields like this
            var orderId = orderData['orderId'];
            var servantName = orderData['servantName'];
            var userName = orderData['userName'];
            var jobType = orderData['jobType'];

            return Card(
              elevation: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(height: 5,),
                  Text('Order ID: $orderId', style: TextStyle(color: Colors.black)),
                  Divider(color: Colors.black),
                  Text('Servant Name: $servantName', style: TextStyle(color: Colors.black)),
                  Text('User Name: $userName', style: TextStyle(color: Colors.black)),
                  Text('Job Type: $jobType', style: TextStyle(color: Colors.black)),
                  SizedBox(height: 5,),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
