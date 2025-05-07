import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'XXX Laptop', price: 137.50, image: 'resource/images/1.png'),
    Product(name: 'XXX 16 \'Inch Wheel', price: 99.50, image: 'resource/images/2.png'),
    Product(name: 'XXX Luxury Chair', price: 145.00, image: 'resource/images/3.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
