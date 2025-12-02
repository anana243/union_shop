import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/app_layout.dart';
import 'package:union_shop/widgets/product_tile.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

Widget _appWithRoutes(Widget home) {
  return MaterialApp(
    routes: {
      '/': (context) => home,
      '/product': (context) => const ProductPage(),
    },
    initialRoute: '/',
  );
}

void main() {
  testWidgets('HomePage renders sections and View All button', (tester) async {
    await tester.pumpWidget(_appWithRoutes(const HomePage()));
    await tester.pump(); // small pump is enough; we don’t wait for network
    expect(find.text('Essential Range — over 20% off!'), findsOneWidget);
    expect(find.text('Signature Range'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
    expect(find.text('VIEW ALL'), findsOneWidget);
  });

  testWidgets('Tapping product title navigates to ProductPage', (tester) async {
    await tester.pumpWidget(_appWithRoutes(const HomePage()));
    await tester.pump();

    // Tap by title text (more reliable than tapping the entire tile)
    final titleFinder = find.text('Essential Hoodie');
    expect(titleFinder, findsOneWidget);
    await tester.tap(titleFinder);
    await tester.pump(); // next frame
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}