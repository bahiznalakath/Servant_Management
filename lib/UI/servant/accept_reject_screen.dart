import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servantmanagement/UI/servant/serventdrawerpage.dart';

class AcceptRejectPage extends StatefulWidget {
  const AcceptRejectPage({Key? key}) : super(key: key);

  @override
  _AcceptRejectPageState createState() => _AcceptRejectPageState();
}

class _AcceptRejectPageState extends State<AcceptRejectPage> {
  Stream<QuerySnapshot>? orderStream;

  @override
  void initState() {
    super.initState();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('workerName', isEqualTo: firebaseUser?.displayName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders from Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffe76f86),
        centerTitle: true,
      ),
      drawer: const ServentDrawerPage(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffe76f86),
              Color(0xffd3bde5),
            ],
          ),
        ),
        child: StreamBuilder(
          stream: orderStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final orders = snapshot.data!.docs;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  final order = orders[index];
                  final orderData = order.data() as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      title: Text(
                        orderData['workerName'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      subtitle: Text(orderData['jobType'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, size: 35),
                            color: Colors.green,
                            onPressed: () {
                              // Implement logic for accepting the order here
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 35),
                            color: Colors.red,
                            onPressed: () {
                              // Implement logic for rejecting the order here
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
