import '../models/product.dart';

class CartModel {
  static final List<Map<String, dynamic>> _cart = [];

  static void add(Product product, String size) {
    _cart.add({"product": product, "size": size});
  }

  static List<Map<String, dynamic>> get cartItems => _cart;

  static void removeAt(int index) {
    _cart.removeAt(index);
  }

  static double get totalPrice => _cart.fold(
      0, (sum, item) => sum + (item["product"] as Product).price);

  static int get totalCount => _cart.length;
}

