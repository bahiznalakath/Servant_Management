import 'package:flutter/material.dart';
import 'package:servantmanagement/UI/servant/view_history_screen.dart';

class HistoryMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffe76f86),
          title: Text("History Of Works",style: TextStyle(fontWeight: FontWeight.bold),),
          bottom: TabBar(
            tabs: [
              Tab(text: "Confirmed"), // First tab
              Tab(text: "Rejected"),  // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryOfWorks(),
            HistoryOfWorks(),
          ],
        ),
      ),
    );
  }
}

