import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class MerchandisePage extends StatelessWidget {
  const MerchandisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Merchandise',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FutureBuilder<List<Product>>(
                  future: ProductRepository().listByCollection('merchandise'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final items = snapshot.data ?? [];
                    if (items.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text('No products found',
                              style: TextStyle(color: Colors.grey)),
                        ),
                      );
                    }
                    return ProductGrid(products: items);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
