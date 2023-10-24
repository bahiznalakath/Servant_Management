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
      final data = doc.data() as Map<String, dynamic>;
      final workerName = data['workerName'];
      final userName = data['userName'];
      final bookingDate = data['timestamp'].toDate();

      if (data['jobType'] == 'User') {
        userBookings.add({'name': workerName, 'bookingDate': bookingDate});
      } else {
        servantBookings.add({
          'userName': userName,
          'workerName': workerName,
          'bookingDate': bookingDate,
        });
      }
    });

    // Ensure the state is updated after fetching data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: userBookings.length,
            itemBuilder: (context, index) {
              final booking = userBookings[index];
              return ListTile(
                title: Text(booking['name']),
                subtitle: Text('Booking Date: ${booking['bookingDate']}'),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Servant Bookings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: servantBookings.length,
            itemBuilder: (context, index) {
              final booking = servantBookings[index];
              return Card(
                child: ListTile(
                  title: Text('Booking from ${booking['userName']} to ${booking['workerName']}'),
                  subtitle: Text('Booking Date: ${booking['bookingDate']}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
