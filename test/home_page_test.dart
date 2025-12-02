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
    await tester.pumpAndSettle();

    expect(find.text('Essential Range — over 20% off!'), findsOneWidget);
    expect(find.text('Signature Range'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
    expect(find.text('VIEW ALL'), findsOneWidget);
  });

  testWidgets('Clicking a product opens ProductPage with arguments', (tester) async {
    await tester.pumpWidget(_appWithRoutes(const HomePage()));
    await tester.pumpAndSettle();

    // Tap the first ProductTile
    final tileFinder = find.byType(ProductTile).first;
    expect(tileFinder, findsOneWidget);
    await tester.tap(tileFinder);
    await tester.pumpAndSettle();

    // ProductPage should show placeholder details text
    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}