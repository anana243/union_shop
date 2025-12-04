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
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.8, // tile height vs width - increased to prevent overflow
        ),
        itemCount: products.length,
        itemBuilder: (context, i) => ProductTile(product: products[i]),
      ),
    );
  }
}
