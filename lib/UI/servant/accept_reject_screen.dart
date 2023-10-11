import 'package:flutter/material.dart';
import 'package:servantmanagement/UI/servant/serventdrawerpage.dart';
// pass order conferm from page of user  workers deta
class AcceptRejectPage extends StatefulWidget {
  const AcceptRejectPage({Key? key}) : super(key: key);

  @override
  _AcceptRejectPageState createState() => _AcceptRejectPageState();
}

class _AcceptRejectPageState extends State<AcceptRejectPage> {
  // Dummy list of orders for demonstration
  final List<Order> orders = [
    Order(id: 1, name: 'Order 1', description: 'Description of Order 1'),
    Order(id: 2, name: 'Order 2', description: 'Description of Order 2'),
    // Add more orders here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: const Color(0xffe76f86),
      ),
      drawer: const ServentDrawerPage(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffe76f86),
            Color(0xffd3bde5),
          ]),
        ),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            final order = orders[index];
            return ListTile(
              title: Text(order.name),
              subtitle: Text(order.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    onPressed: () {
                      // Implement logic to accept the order here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.red,
                    onPressed: () {
                      // Implement logic to reject the order here
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Order {
  final int id;
  final String name;
  final String description;

  Order({
    required this.id,
    required this.name,
    required this.description,
  });
}
