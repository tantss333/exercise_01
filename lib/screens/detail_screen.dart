import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';
import 'cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  DetailScreen({required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            widget.product.image,
            width: double.infinity,
            height: 230,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Product description goes here.", style: TextStyle(fontSize: 16)),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Select Size:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["Large", "Medium", "Small"].map((option) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: Text(option),
                  selected: selectedOption == option,
                  onSelected: (_) {
                    setState(() {
                      if (selectedOption == option) {
                        selectedOption = null;
                      } else {
                        selectedOption = option;
                      }
                    });
                  },
                ),
              );
            }).toList(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    if (selectedOption == null) {
                      showCenteredDialog(context, '⚠️ Please select an option.');
                      return;
                    }

                    CartModel.add(widget.product, selectedOption!);
                    showCenteredDialog(context, '✅ Added to cart');
                  },
                  child: Text("Add to cart"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Popup window function
void showCenteredDialog(BuildContext context, String message) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      Future.delayed(Duration(seconds: 1), () {
        if (Navigator.canPop(context)) Navigator.of(context).pop();
      });

      return Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 180,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    },
  );
}
