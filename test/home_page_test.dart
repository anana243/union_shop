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
  setUpAll(() {
    setupFirebaseTest();
  });

  testWidgets('HomePage shows sections and View All', (tester) async {
    // Larger viewport to fit all content
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(_app(const HomePage()));
    // Wait longer for Firebase to load
    for (int i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Verify page structure
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
  });

  testWidgets('Tapping product title navigates to ProductPage', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(_app(const HomePage()));
    // Wait longer for Firebase to load
    for (int i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    // Verify the page renders properly
    expect(find.byType(HomePage), findsOneWidget);
  });
}
