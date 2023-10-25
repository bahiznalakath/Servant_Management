import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewTotalBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TotalBookingsContent(),
    );
  }
}

class TotalBookingsContent extends StatefulWidget {
  @override
  _TotalBookingsContentState createState() => _TotalBookingsContentState();
}

class _TotalBookingsContentState extends State<TotalBookingsContent> {
  List<Map<String, dynamic>> userBookings = [];
  List<Map<String, dynamic>> servantBookings = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final ordersCollection = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await ordersCollection.get();

    querySnapshot.docs.forEach((doc) {
      final data = doc.data();
      final workerName = data['workerName'];
      final userName = data['userName'];
      final bookingDate = data['timestamp'].toDate();

      if (data['jobType'] == 'User') {
        setState(() {
          userBookings.add({'name': workerName, 'bookingDate': bookingDate});
        });
      } else {
        setState(() {
          servantBookings.add({
            'userName': userName,
            'workerName': workerName,
            'bookingDate': bookingDate,
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: userBookings.length,
              itemBuilder: (context, index) {
                final booking = userBookings[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(booking['name']),
                    subtitle: Text('Booking Date: ${booking['bookingDate']}'),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: servantBookings.length,
              itemBuilder: (context, index) {
                final booking = servantBookings[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Booking from ${booking['userName']} to ${booking['workerName']}'
                    ),
                    subtitle: Text('Booking Date: ${booking['bookingDate']}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
