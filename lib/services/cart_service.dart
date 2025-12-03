import '../models/product.dart';

class CartService {
  CartService._();
  static final CartService instance = CartService._();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add(Product p) => _items.add(p);
  void remove(Product p) => _items.removeWhere((i) => i.id == p.id);
  void clear() => _items.clear();
}