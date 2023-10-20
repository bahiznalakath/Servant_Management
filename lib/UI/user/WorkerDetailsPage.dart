import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Firebase/Model/servant_model.dart';

class WorkerList extends StatefulWidget {
  final String jobType;

  const WorkerList({Key? key, required this.jobType}) : super(key: key);

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  final List<ServantModel> selectedWorkers = [];
  String myEmail = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('servants')
          .where('jobType', isEqualTo: widget.jobType)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<ServantModel> workers = snapshot.data!.docs.map((document) {
          return ServantModel.fromJson(document.data() as Map<String, dynamic>);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Worker List of - ${widget.jobType}', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: const Color(0xffe76f86),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffe76f86),
                  Color(0xffd3bde5),
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];

                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 200,
                        width: 400,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              worker.email ?? 'No Name',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Experience: ${worker.experience ?? 0} years',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                placeOrder(worker);
                              },
                              child: Text('Booking of ${worker.userName}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void placeOrder(ServantModel worker) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');
        final timestamp = DateTime.now();
        ordersCollection.add({
          'workerId': worker.uid,
          'jobType': worker.jobType,
          'workerName': worker.userName,
          'userId': user.uid,
          'userName': username,
          'timestamp': timestamp,
        });

        Fluttertoast.showToast(
          msg: "Order for ${worker.userName} confirmed.",
          toastLength: Toast.LENGTH_SHORT,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Failed to place an order for ${worker.userName}.",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "You need to sign in to place an order.",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          myEmail = ds.data()?['email'];
          username = ds.data()?['userName'];
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
