import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servantmanagement/UI/servant/serventdrawerpage.dart';// Corrected the import statement

class AcceptRejectPage extends StatefulWidget {
  const AcceptRejectPage({Key? key}) : super(key: key);

  @override
  _AcceptRejectPageState createState() => _AcceptRejectPageState();
}

class _AcceptRejectPageState extends State<AcceptRejectPage> {
  Stream<QuerySnapshot>? orderStream;
  String servantname = '';
  String email = '';
  String jobType = '';
  int experience = 0;
  String username = '';
  String userId = '';
  int timestamp = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookings from Users to $servantname', // Removed unnecessary {}
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
                      title: Text("You have a booking for $jobType"),
                      subtitle: Column(
                        children: [
                          Text(
                            orderData['userName'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, size: 35),
                            color: Colors.green,
                            onPressed: () {
                              // Implement logic for accepting the order here
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close, size: 35),
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

  _fetchUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('servants')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          email = ds.data()?['email'] ?? '';
          servantname = ds.data()?['userName'] ?? '';
          jobType = ds.data()?['jobType'] ?? '';
          experience = ds.data()?['experience'] ?? 0;
          _setupOrderStream(); // Call to set up the orderStream after user data is fetched
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  // Function to set up the Firestore query after user data is fetched
  // Function to set up the Firestore query after user data is fetched
  void _setupOrderStream() {
    orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('workerName', isEqualTo: servantname)
        .where('jobType', isEqualTo: jobType)
        .snapshots();
  }

}
