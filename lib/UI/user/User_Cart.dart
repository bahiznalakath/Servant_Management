import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Firebase/Model/servant_model.dart';

class CartPage extends StatefulWidget {
  final List<ServantModel> selectedWorkers;

  const CartPage({Key? key, required this.selectedWorkers}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final String _prefsKey = 'selectedWorkers';

  @override
  void initState() {
    super.initState();
    _loadSelectedWorkers();
  }

  Future<void> _loadSelectedWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_prefsKey);

    if (savedData != null) {
      final List<dynamic> jsonData = json.decode(savedData);
      final selectedWorkersList = jsonData
          .map((json) => ServantModel.fromJson(json))
          .toList();

      setState(() {
        widget.selectedWorkers.clear();
        widget.selectedWorkers.addAll(selectedWorkersList);
      });
    }
  }

  Future<void> _saveSelectedWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedWorkersJson =
    json.encode(widget.selectedWorkers.map((model) => model.toJson()).toList());
    await prefs.setString(_prefsKey, selectedWorkersJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
          itemCount: widget.selectedWorkers.length,
          itemBuilder: (context, index) {
            final worker = widget.selectedWorkers[index];
            return ListTile(
              title: Text(worker.userName ?? 'No Name'),
              subtitle: Text('Experience: ${worker.experience ?? 0} years'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.selectedWorkers.removeAt(index);
                    _saveSelectedWorkers();
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
