import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/product_page.dart';

Widget _app(Widget home) => MaterialApp(
  routes: {
    '/': (context) => home,
    '/product': (context) => const ProductPage(),
  },
  initialRoute: '/',
);

void main() {
  setupTests();

  testWidgets('HomePage shows sections and View All', (tester) async {
    await tester.pumpWidget(_app(const HomePage()));
    await tester.pump();
    expect(find.text('Essential Range — over 20% off!'), findsOneWidget);
    expect(find.text('Signature Range'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
    expect(find.text('VIEW ALL'), findsOneWidget);
  });

  testWidgets('Tapping product title navigates to ProductPage', (tester) async {
    await tester.pumpWidget(_app(const HomePage()));
    await tester.pump();

    final title = find.text('Essential Hoodie');
    expect(title, findsOneWidget);

    await tester.tap(title);
    await tester.pumpAndSettle();

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}