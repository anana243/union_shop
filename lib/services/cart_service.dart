import 'package:flutter/foundation.dart';
import '../models/product.dart';

// Simple observable cart singleton
class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    _items.removeWhere((i) => i.id == p.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}