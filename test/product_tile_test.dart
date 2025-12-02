import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/widgets/product_tile.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

void main() {
  setupTests();

  testWidgets('ProductTile navigates to ProductPage', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    const product = Product(
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

    await tester.pumpWidget(app);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);

    await tester.tap(find.text('Tile Product'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);
  });
}