import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../models/product.dart';
import '../services/product_repository.dart';
import '../widgets/product_tile.dart';

class GraduationPage extends StatelessWidget {
  const GraduationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository();

    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Graduation',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Celebrate your achievements with our graduation collection',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            FutureBuilder<List<Product>>(
              future: repo.listByCollection('graduation'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(48.0),
                      child: Text('No products found'),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) => ProductTile(product: products[i]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
