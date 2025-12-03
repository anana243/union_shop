import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_tile.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool twoColumnGrid;
  const ProductGrid({super.key, required this.products, this.twoColumnGrid = false});

  @override
  Widget build(BuildContext context) {
    if (twoColumnGrid) {
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
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 24,
      runSpacing: 24,
      children: products
          .map((p) => ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 220),
                child: ProductTile(product: p),
              ))
          .toList(),
    );
  }
}
