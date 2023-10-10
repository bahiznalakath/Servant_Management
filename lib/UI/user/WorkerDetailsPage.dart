import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Firebase/Model/servant_model.dart';

class WorkerList extends StatelessWidget {
  final String jobType;

  WorkerList({required this.jobType});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('servants')
          .where('jobType', isEqualTo: jobType) // Filter by jobType
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<ServantModel> workers = snapshot.data!.docs.map((document) {
          return ServantModel.fromMap(document.data() as Map<String, dynamic>);
        }).toList();

        print(workers);

        return Scaffold(
          appBar: AppBar(
            title: Text('Worker List of - $jobType'),
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
                      elevation: 3, // Add elevation for a shadow effect
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Add rounded corners
                      ),
                      child: Container(
                        height: 150,
                        width: 340,
                        padding: const EdgeInsets.all(16.0),
                        // Add padding for spacing
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
                              height: 5, // Adjust spacing
                            ),
                            Text(
                              'Experience: ${worker.experience ?? 0} years',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // Adjust font size
                                color: Colors
                                    .grey, // Add some color to secondary information
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Add to Cart button
                                ElevatedButton(
                                  onPressed: () {
                                    // Implement add to cart logic here
                                  },
                                  child: const Text('Add to Cart'),
                                ),
                                // Rating system (e.g., using stars)
                                const Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star_border, color: Colors.yellow),
                                    Icon(Icons.star_border, color: Colors.yellow),
                                  ],
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
        );
      },
    );
  }
}
