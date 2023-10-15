import 'package:flutter/material.dart';

class ViewTotalBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Total Bookings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffe76f86),
        centerTitle: true,
      ),
      body: TotalBookingsContent(),
    );
  }
}
class TotalBookingsContent extends StatefulWidget {
  @override
  _TotalBookingsContentState createState() => _TotalBookingsContentState();
}

class _TotalBookingsContentState extends State<TotalBookingsContent> {
  List<Map<String, dynamic>> userBookings = [
    {'name': 'User 1', 'bookingDate': '2023-10-15'},
    {'name': 'User 2', 'bookingDate': '2023-10-16'},
    // Add more user bookings here
  ];

  List<Map<String, dynamic>> servantBookings = [
    {'name': 'Servant 1', 'bookingDate': '2023-10-17'},
    {'name': 'Servant 2', 'bookingDate': '2023-10-18'},
    // Add more servant bookings here
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'User Bookings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
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
              return ListTile(
                title: Text(booking['name']),
                subtitle: Text('Booking Date: ${booking['bookingDate']}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
