import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servantmanagement/UI/admin/view_total_bookings_screen.dart';

import 'manage_servants_screen.dart';
import 'manage_users_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int userCount = 0;
  int servantCount = 0;

  @override
  void initState() {
    super.initState();
    fetchUserAndServantCounts();
  }

  Future<void> fetchUserAndServantCounts() async {
    final usersQuery = FirebaseFirestore.instance.collection('users');
    final servantsQuery = FirebaseFirestore.instance.collection('servants');

    final userDocuments = await usersQuery.get();
    final servantDocuments = await servantsQuery.get();

    setState(() {
      userCount = userDocuments.docs.length;
      servantCount = servantDocuments.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin for Servants Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe76f86),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Manage Users (${userCount.toString()})'),
            Tab(text: 'Manage Servants (${servantCount.toString()})'),
            Tab(text: 'View Total Bookings'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ServantManagementPage(),
          UserManagementPage(),
          ViewTotalBookingsPage()
        ],
      ),
    );
  }
}
