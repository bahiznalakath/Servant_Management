import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryOfWorksRejected extends StatefulWidget {
  const HistoryOfWorksRejected({Key? key}) : super(key: key);

  @override
  _HistoryOfWorksRejectedState createState() => _HistoryOfWorksRejectedState();
}

class _HistoryOfWorksRejectedState extends State<HistoryOfWorksRejected> {
  String myEmail = "";
  String username = "";
  List<Map<String, dynamic>> confirmedOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      try {
        final ds = await FirebaseFirestore.instance
            .collection('servants')
            .doc(firebaseUser.uid)
            .get();
        setState(() {
          myEmail = ds.data()?['email'] ?? '';
          username = ds.data()?['userName'] ?? '';
        });
        await _fetchConfirmedOrders();
      } catch (e) {
        print(e);
        // Handle the error here
      }
    }
  }

  _fetchConfirmedOrders() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('confirmed_orders')
          .where('userName', isEqualTo: username)
          .get();

      final orders = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        confirmedOrders = orders;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      // Handle the error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffe76f86),
            Color(0xffd3bde5),
          ]),
        ),
        child: isLoading
            ? Container(child: Center(child: CircularProgressIndicator())) // Show a loading indicator
            : ListView.builder(
          itemCount: confirmedOrders.length,
          itemBuilder: (BuildContext context, int index) {
            var order = confirmedOrders[index];
            return Card(
              elevation: 8,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text("Rejected Works ID: ${order['orderId']}"),
                subtitle: Text("The user Name: ${order['userName']}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
