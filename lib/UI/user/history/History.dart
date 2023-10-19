import 'package:flutter/material.dart';
import 'Rejected.dart';
import 'conform.dart';

class HistoryOfOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xffe76f86),
          title: Text("History Of Orders",style: TextStyle(fontWeight: FontWeight.bold),),
          bottom: TabBar(
            tabs: [
              Tab(text: "Confirmed"), // First tab
              Tab(text: "Rejected"),  // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryOfConfirmed(),
            HistoryOfRejected(),
          ],
        ),
      ),
    );
  }
}

