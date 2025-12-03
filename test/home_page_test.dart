import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';

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
    // Larger viewport to fit all content
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(_app(const HomePage()));
    await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for timers

    expect(find.text('Essential Range — over 20% off!'), findsOneWidget);
    expect(find.text('Signature Range'), findsOneWidget);
    expect(find.text('Portsmouth City Collection'), findsOneWidget);
    expect(find.text('VIEW ALL'), findsOneWidget);
  });

  testWidgets('Tapping product title navigates to ProductPage', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(_app(const HomePage()));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Scroll to bring "Essential Hoodie" into viewport
    await tester.scrollUntilVisible(
      find.text('Essential Hoodie'),
      100.0,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(find.text('Essential Hoodie'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}
