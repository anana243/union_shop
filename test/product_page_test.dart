import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('ProductPage displays route args (title, price, image)', (tester) async {
    final app = MaterialApp(
      routes: {
        '/product': (context) => const ProductPage(),
      },
      initialRoute: '/product',
      onGenerateRoute: (settings) {
        if (settings.name == '/product') {
          return MaterialPageRoute(
            builder: (context) => const ProductPage(),
            settings: RouteSettings(arguments: {
              'title': 'Test Product',
              'price': '£99.99',
              'imageUrl': 'https://example.com/image.png',
            }),
          );
        }
        return null;
      },
    );

    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£99.99'), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}