import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../models/product.dart';
import '../services/product_repository.dart';
import '../widgets/product_grid.dart';

class PortsmouthCityPage extends StatelessWidget {
  const PortsmouthCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository();

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
                  'Portsmouth City Collection',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<Product>>(
                  future: repo.listByCollection('city'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text('Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red)),
                        ),
                      );
                    }

                    final products = snapshot.data ?? [];
                    if (products.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text('No products found',
                              style: TextStyle(color: Colors.grey)),
                        ),
                      );
                    }

                    return ProductGrid(products: products);
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
