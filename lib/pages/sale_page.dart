import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/hero_carousel.dart';
import '../constants.dart';
import '../widgets/product_grid.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});
  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository();
    return AppLayout(
      title: 'Union',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeroCarousel(imageUrl: kHeroImageUrl),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('Union Sale',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    "Get yours before they're all gone. All prices shown are inclusive of the discounts.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: FutureBuilder<List<Product>>(
                future: repo.listByCollection('sale'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
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
                  return ProductGrid(products: products);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
