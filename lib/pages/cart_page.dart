import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: AnimatedBuilder(
          animation: CartService.instance,
          builder: (context, _) {
            final items = CartService.instance.items;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                        tooltip: 'Back'),
                    const SizedBox(width: 8),
                    const Text('Shopping Cart',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 24),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('Your cart is empty',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height: 8),
                          Text('Browse products and add them to your cart.',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, i) {
                      final p = items[i];
                      return ListTile(
                        leading: SizedBox(
                          width: 56,
                          height: 56,
                          child: Image.network(
                            p.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image)),
                          ),
                        ),
                        title: Text(p.title),
                        subtitle: Text('£${p.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => CartService.instance.remove(p),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
