import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Firebase/Model/servant_model.dart';
import 'user_cart.dart'; // Assuming you have a UserCart class

class WorkerList extends StatefulWidget {
  final String jobType;

  const WorkerList({Key? key, required this.jobType}) : super(key: key);

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  final List<ServantModel> selectedWorkers = [];

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
            title: Text('Worker List of - ${widget.jobType}'),
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
                final isWorkerInCart = selectedWorkers.contains(worker);

                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 150,
                        width: 340,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker.userName ?? 'No Name',
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
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    isWorkerInCart
                                        ? removeFromCart(worker)
                                        : addToCart(worker);
                                  },
                                  child: Text(
                                    isWorkerInCart
                                        ? 'REMOVE FROM CART'
                                        : 'ADD TO CART',
                                  ),
                                ),
                              ],
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
          floatingActionButton: ElevatedButton(
            onPressed: navigateToCartPage,
            child: Text('Go to Cart (${selectedWorkers.length})'),
          ),
        );
      },
    );
  }

  void addToCart(ServantModel worker) {
    setState(() {
      selectedWorkers.add(worker);
    });
    Fluttertoast.showToast(
      msg: "Worker added to cart successfully",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void removeFromCart(ServantModel worker) {
    setState(() {
      selectedWorkers.remove(worker);
    });
    Fluttertoast.showToast(
      msg: "Worker removed from cart",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void navigateToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(selectedWorkers: selectedWorkers),
      ),
    ).then((value) {
      // Clear the selectedWorkers list when returning from CartPage
      selectedWorkers.clear();
    });
  }
}

