import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/widgets/product_tile.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/product_page.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  testWidgets('ProductTile navigates to ProductPage', (tester) async {
    setupDesktopViewportWithReset(tester);

    const product = Product(
      id: '1',
      title: 'Tile Product',
      price: 12.00,
      imageUrl: 'https://example.com/image.png',
      slug: 'tile-product',
    );

    final app = MaterialApp(
      routes: {
        '/': (context) => const Scaffold(body: ProductTile(product: product)),
        '/product': (context) => const ProductPage(),
      },
      initialRoute: '/',
    );

    await tester.pumpWidget(app);
    await waitForAsync(tester, iterations: 10);

    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);

    await tester.tap(find.text('Tile Product'));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Tile Product'), findsOneWidget);
    expect(find.text('£12.00'), findsOneWidget);
  });
}
