import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Color(0xffe76f86),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe76f86), Color(0xffd3bde5)],
          ),
        ),
        child: ListView.builder(
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteItems[index];
            return Column(
              children: [
                SingleChildScrollView(
                  child: Card(
                    child: ListTile(
                      title: Text(item['worker-name'] ?? ''), // Display the worker's name or 'No Name' if it's null
                      subtitle: Text(item['jobType'] ?? ''), // Display the job type or 'No Job Type' if it's null
                      contentPadding: EdgeInsets.all(25),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _fetchFavorites() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('user_carts')
            .doc(firebaseUser.uid)
            .collection('cart_items')
            .get();
        setState(() {
          favoriteItems = querySnapshot.docs
              .map((doc) => doc.data())
              .toList();
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
