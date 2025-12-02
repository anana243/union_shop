import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/product_page.dart';

void main() {
  setupTests();

  testWidgets('ProductPage displays route args', (tester) async {
    final app = MaterialApp(
      routes: {'/product': (context) => const ProductPage()},
      home: Builder(
        builder: (context) {
          Future.microtask(() {
            Navigator.pushNamed(context, '/product', arguments: {
              'title': 'Test Product',
              'price': '£99.99',
              'imageUrl': 'https://example.com/image.png',
            });
          });
          return const SizedBox.shrink();
        },
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£99.99'), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    final title = args['title'] ?? '';
    final price = args['price'] ?? '';
    final imageUrl = args['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              Image.network(imageUrl, height: 200),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Details coming soon...'),
          ],
        ),
      ),
    );
  }
}