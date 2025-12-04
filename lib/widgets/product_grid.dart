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
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 24,
        children: products
            .map((p) => ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 240),
                  child: ProductTile(product: p),
                ))
            .toList(),
      ),
    );
  }
}
