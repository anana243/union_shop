import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/widgets/product_tile.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

void main() {
  setupTests();

  testWidgets('ProductTile navigates to ProductPage with args', (tester) async {
    final product = const Product(
      title: 'Tile Product',
      price: '£12.00',
      imageUrl: 'https://example.com/image.png',
      slug: 'tile-product',
    );

    final app = MaterialApp(
      routes: {
        '/': (context) => Scaffold(body: ProductTile(product: product)),
        '/product': (context) => const ProductPage(),
      },
      initialRoute: '/',
    );

    await tester.pump();

    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);

    await tester.tap(find.text('Tile Product'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);
  });
}