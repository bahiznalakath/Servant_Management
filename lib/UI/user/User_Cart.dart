import 'package:flutter/material.dart';



class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> favoriteServices = [
    'Service 1',
    'Service 2',
    'Service 3',
    // Add your favorite services here
  ];
  List<String> cartItems = [];

  void addToCart(String service) {
    setState(() {
      cartItems.add(service);
    });
  }

  void removeFromCart(String service) {
    setState(() {
      cartItems.remove(service);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor:    const Color(0xffe76f86),
      ),
      body: Container( height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffe76f86),
            Color(0xffd3bde5),
          ]),
        ),
        child: ListView.builder(
          itemCount: favoriteServices.length,
          itemBuilder: (context, index) {
            final service = favoriteServices[index];
            final isAddedToCart = cartItems.contains(service);

            return ListTile(
              title: Text(service),
              trailing: isAddedToCart
                  ? IconButton(
                icon: const Icon(Icons.remove_shopping_cart),
                onPressed: () => removeFromCart(service),
              )
                  : IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () => addToCart(service),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement your checkout logic here
          // You can use the `cartItems` list to process the selected services
          // For example, you can navigate to a checkout page or show a dialog.
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
