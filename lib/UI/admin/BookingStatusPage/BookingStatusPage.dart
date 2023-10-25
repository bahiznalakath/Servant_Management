import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'confirmedBookings.dart';
import 'pendingBookings.dart';
import 'rejectedBookings.dart';

class BookingStatusPage extends StatefulWidget {
  const BookingStatusPage({Key? key}) : super(key: key);

  @override
  _BookingStatusPageState createState() => _BookingStatusPageState();
}

class _BookingStatusPageState extends State<BookingStatusPage>
    with SingleTickerProviderStateMixin {
  int confirmedBookings = 0;
  int rejectedBookings = 0;
  int pendingBookings = 0;
  late TabController _tabController;

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
    final confirmedQuery =
    FirebaseFirestore.instance.collection('confirmed_orders');
    final rejectedQuery =
    FirebaseFirestore.instance.collection('reject_orders');
    final pendingQuery = FirebaseFirestore.instance.collection('orders');
    final confirmedDocuments = await confirmedQuery.get();
    final rejectedDocuments = await rejectedQuery.get();
    final pendingDocuments = await pendingQuery.get();

    setState(() {
      confirmedBookings = confirmedDocuments.docs.length;
      rejectedBookings = rejectedDocuments.docs.length;
      pendingBookings = pendingDocuments.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Confirmed Bookings ($confirmedBookings)'),
              Tab(text: 'Rejected Bookings ($rejectedBookings)'),
              Tab(text: 'Pending Bookings ($pendingBookings)'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ConfirmedBookingsPage(),
                RejectedBookingsPage(),
                ViewTotalBooking(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
