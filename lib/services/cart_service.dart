import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Simple observable cart singleton
class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  int get count => _items.values.fold(0, (sum, item) => sum + item.quantity);
  double get total => _items.values
      .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  void add(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity++;
    } else {
      _items[p.id] = CartItem(product: p);
    }
    notifyListeners();
  }

  void remove(Product p) {
    _items.remove(p.id);
    notifyListeners();
  }

  void updateQuantity(Product p, int quantity) {
    if (quantity <= 0) {
      _items.remove(p.id);
    } else if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity = quantity;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
