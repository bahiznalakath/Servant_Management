import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Login.dart';
import 'BookingStatusPage/BookingStatusPage.dart';
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
      if (_tabController.index == 0) {
      } else if (_tabController.index == 1) {
      } else if (_tabController.index == 2) {}
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        // Increase the height to your desired value
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xffe76f86),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 40,
              ),
              Text(
                'Admin DashBoard',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () async {
                  try {
                    Fluttertoast.showToast(
                        msg: "logging out Admin Successful ");
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(), // Replace with your login screen widget
                      ),
                    );
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Error logging out: $e');
                    print('Error logging out: $e');
                  }
                },
                icon: Icon(Icons.logout, color: Colors.black),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'ManageServants(${servantCount.toString()})'),
              Tab(text: 'ManageUsers(${userCount.toString()})'),
              Tab(text: 'View Total Bookings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ServantManagementPage(),
                UserManagementPage(),
                BookingStatusPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
