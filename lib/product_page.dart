import 'package:flutter/material.dart';
import 'app_layout.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final title = args?['title'] as String? ?? 'Product';
    final price = args?['price'] as String? ?? '';
    final imageUrl = args?['imageUrl'] as String? ?? '';

    return AppLayout(
      title: 'Union',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (price.isNotEmpty) Text(price, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),
            if (imageUrl.isNotEmpty)
              AspectRatio(aspectRatio: 1, child: Image.network(imageUrl, fit: BoxFit.cover)),
            const SizedBox(height: 24),
            const Text('Details coming soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
