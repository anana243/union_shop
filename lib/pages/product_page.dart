import 'package:flutter/material.dart';
import '../models/product.dart';
import '../app_layout.dart';
import '../services/cart_service.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the Product object passed via Navigator
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    if (product == null) {
      return const AppLayout(
        title: 'Product Not Found',
        child: Center(
          child: Text('Product not found', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 200,
        ),
        color: Colors.white,
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 700;
                final image = Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                      height: 300,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50)),
                );

                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        CartService.instance.add(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('ADD TO CART'),
                    ),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: AspectRatio(aspectRatio: 1, child: image)),
                      const SizedBox(width: 40),
                      Expanded(child: details),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(aspectRatio: 1, child: image),
                      const SizedBox(height: 24),
                      details,
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
