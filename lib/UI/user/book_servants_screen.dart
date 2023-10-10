import 'package:flutter/material.dart';

class BookServantPage extends StatelessWidget {
  const BookServantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Servant'),
        backgroundColor: const Color(0xffe76f86),
      ),
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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your content here
              Text(
                'Welcome to the Book a Servant Page!',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              // Replace the Placeholder widget with your content
              Placeholder(),
            ],
          ),
        ),
      ),
    );
  }
}


