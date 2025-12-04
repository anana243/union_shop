import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/shop_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('ShopPage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(width: 1200, child: ShopPage()),
        ),
      );

      // The title "All Products" is displayed as page title (large text)
      final allProductsTexts = find.text('All Products');
      expect(allProductsTexts, findsWidgets);
      // Just check that it exists, don't specify exactly one since it appears in dropdown too
    });

    testWidgets('has filter dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(width: 1200, child: ShopPage()),
        ),
      );

      expect(find.text('Filter:'), findsOneWidget);
      // Just verify the filter text exists somewhere
      final allProductsTexts = find.text('All Products');
      expect(allProductsTexts, findsWidgets);
    });

    testWidgets('has sort dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(width: 1200, child: ShopPage()),
        ),
      );

      expect(find.text('Sort:'), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('filter dropdown shows all options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      // Tap the filter dropdown - find the first occurrence in dropdown
      await tester.tap(find.byType(DropdownButton<String>).first);
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('Portsmouth City Collection'), findsOneWidget);
      expect(find.text('Signature Range'), findsOneWidget);
      expect(find.text('Essential Range'), findsOneWidget);
    });

    testWidgets('sort dropdown shows all options', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SizedBox(width: 1200, child: ShopPage()),
        ),
      );

      // Tap the sort dropdown
      await tester.tap(find.text('Featured'));
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      expect(find.text('Alphabetically, A-Z'), findsOneWidget);
      expect(find.text('Alphabetically, Z-A'), findsOneWidget);
      expect(find.text('Price, Low to High'), findsOneWidget);
      expect(find.text('Price, High to Low'), findsOneWidget);
    });
  });
}
