import 'package:flutter/material.dart';
import '../app_layout.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context), tooltip: 'Back'),
                const SizedBox(width: 8),
                const Text('Shopping Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text('Browse products and add them to your cart.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}