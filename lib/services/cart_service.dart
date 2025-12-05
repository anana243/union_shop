import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Represents a product with its quantity in the shopping cart.
class CartItem {
  /// The product being stored in the cart.
  final Product product;
  
  /// Quantity of this product in the cart.
  int quantity;

  /// Creates a [CartItem].
  /// 
  /// [quantity] defaults to 1 if not specified.
  CartItem({required this.product, this.quantity = 1});
}

/// Singleton service managing the shopping cart state.
/// 
/// Extends [ChangeNotifier] to provide reactive updates when the cart changes.
/// Use [CartService.instance] to access the singleton instance.
class CartService extends ChangeNotifier {
  CartService._();
  
  /// Singleton instance of the cart service.
  static final CartService instance = CartService._();

  final Map<String, CartItem> _items = {};

  /// Get all items currently in the cart.
  List<CartItem> get items => _items.values.toList();
  
  /// Get the total number of products in the cart (considering quantities).
  int get count => _items.values.fold(0, (sum, item) => sum + item.quantity);
  
  /// Get the total price of all items in the cart.
  double get total => _items.values
      .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  /// Adds a product to the cart.
  /// 
  /// If the product already exists in the cart, increments its quantity.
  /// Notifies listeners of the change.
  void add(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity++;
    } else {
      _items[p.id] = CartItem(product: p);
    }
    notifyListeners();
  }

  /// Removes a product from the cart entirely.
  /// 
  /// Notifies listeners of the change.
  void remove(Product p) {
    _items.remove(p.id);
    notifyListeners();
  }

  /// Updates the quantity of a product in the cart.
  /// 
  /// If [quantity] is <= 0, removes the product from the cart.
  /// Notifies listeners of the change.
  void updateQuantity(Product p, int quantity) {
    if (quantity <= 0) {
      _items.remove(p.id);
    } else if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity = quantity;
    }
    notifyListeners();
  }

  /// Clears all items from the cart.
  /// 
  /// Notifies listeners of the change.
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
