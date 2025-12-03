import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../models/product.dart';
import '../services/product_repository.dart';
import '../widgets/product_tile.dart';
import '../widgets/hero_carousel.dart';
import '../constants.dart';

class PortsmouthCityPage extends StatelessWidget {
  const PortsmouthCityPage({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 16),
                  Text(
                    'Portsmouth City Collection',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We're excited to launch the Portsmouth City Collection featuring products by renowned British illustrator Julia Gash. Available in our Students Union shop.",
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
              future: repo.listByCollection('city'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: CircularProgressIndicator()));
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
                    childAspectRatio: 1.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) => ProductTile(product: products[i]),
                );
              },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
