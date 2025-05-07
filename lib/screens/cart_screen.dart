import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<int> selectedIndexes = [];

  @override
  void initState() {
    super.initState();

    //Default config of selecting all items in cart
    selectedIndexes.addAll(List.generate(CartModel.cartItems.length, (i) => i));
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartModel.cartItems;

    // calculate the total price according to selected item
    double selectedTotal = selectedIndexes.fold(0, (sum, index) {
      if (index < cartItems.length) {
        final product = cartItems[index]['product'] as Product;
        return sum + product.price;
      }
      return sum;
    });

    return Scaffold(
      appBar: AppBar(
          title: Text("Your Cart"),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            )
          ],

      ),


      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(child: Text("Your cart is empty"))
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final product = item["product"] as Product;
                final size = item["size"];

                return ListTile(
                  leading: Image.asset(product.image, width: 50),
                  title: Text(product.name),
                  subtitle: Text(
                    "\$${product.price.toStringAsFixed(2)}\nOption: $size",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: selectedIndexes.contains(index),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              selectedIndexes.add(index);
                            } else {
                              selectedIndexes.remove(index);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            CartModel.removeAt(index);

                            // 修复索引错乱问题
                            selectedIndexes.remove(index);
                            selectedIndexes
                              ..clear()
                              ..addAll(List.generate(
                                CartModel.cartItems.length,
                                    (i) => i,
                              ));
                          });
                        },
                      ),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Total Items: ${CartModel.totalCount}"),
                Text(
                  "Total: \$${selectedTotal.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  onPressed: selectedIndexes.isEmpty
                      ? null
                      : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Checked out ${selectedIndexes.length} item(s)!"),
                      ),
                    );
                  },
                  child: Text(
                    "🛒 Checkout Selected (${selectedIndexes.length})",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
