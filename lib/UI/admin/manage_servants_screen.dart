import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Manage Users'),
            Tab(text: 'Manage Servants'),
            Tab(text: 'view total bookings',)
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          // Content for managing users
          Center(
            child: Text('User Management Content'),
          ),
          // Content for managing servants
          Center(
            child: Text('Servant Management Content'),
          ),
          Center(
            child: Text('Servant and User view total bookings  Content'),
          ),
        ],
      ),
    );
  }
}
