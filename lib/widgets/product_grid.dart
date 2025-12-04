import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_tile.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool twoColumnGrid;
  const ProductGrid(
      {super.key, required this.products, this.twoColumnGrid = false});

  @override
  Widget build(BuildContext context) {
    // Force 2 columns for consistency across all collections
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 0.7 : 0.8, // Lower ratio for mobile = taller tiles
            ),
            itemCount: products.length,
            itemBuilder: (context, i) => ProductTile(product: products[i]),
          );
        },
      ),
    );
  }
}
