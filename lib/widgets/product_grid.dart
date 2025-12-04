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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 600;
          final maxWidth = isDesktop ? 280.0 : 240.0;
          
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 24,
            children: products
                .map((p) => ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: ProductTile(product: p),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
