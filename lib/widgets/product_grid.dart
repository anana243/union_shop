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
    // Responsive grid: 2/3/4 columns based on width
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (width >= 1100) {
      crossAxisCount = 4;
    } else if (width >= 800) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: twoColumnGrid ? 2 : crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.8, // tile height vs width
      ),
      itemCount: products.length,
      itemBuilder: (context, i) => ProductTile(product: products[i]),
    );
  }
}
