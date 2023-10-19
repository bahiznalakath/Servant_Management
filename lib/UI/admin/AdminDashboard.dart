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

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int userCount = 0;
  int servantCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    fetchUserAndServantCounts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Handle tab change here
      if (_tabController.index == 0) {
        // First tab is selected
      } else if (_tabController.index == 1) {
        // Second tab is selected
      } else if (_tabController.index == 2) {
        // Third tab is selected
      }
    }
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
        title: Text(
          'Admin Dashboard',
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe76f86),
        bottom: TabBar(
          controller: _tabController, // Add TabController
          tabs: [
            Tab(text: 'ManageServants(${servantCount.toString()})'),
            Tab(text: 'ManageUsers(${userCount.toString()})'),
            Tab(text: 'View Total Bookings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Add TabController
        children: [
          ServantManagementPage(),
          UserManagementPage(),
          ViewTotalBookingsPage()
        ],
      ),
    );
  }
}
