import 'package:flutter/material.dart';

import 'admin/login_screen.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Servant Booking  App Details'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'This project is a Servant Booking App that is used to manage and contact servants.'),
            Text('The app has two main modules:'),
            Text(
                '1. User: Allows users to interact with and manage their servants.'),
            Text(
                '2. Client: Provides a platform for clients to connect with and hire servants.'),
            Text(
                '3. Admin: Admins have separate login credentials to manage the application.'),
            // Add more project details here as needed.
          ],
        ),
      ),
      actions: <Widget>[
        Card(
          child: TextButton(
            child: const Text('AdminLogin'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AdminLogin()));
            },
          ),
        ),
        Card(
          child: TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
