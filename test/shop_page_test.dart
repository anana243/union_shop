import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/shop_page.dart';

void main() {
  group('ShopPage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      expect(find.text('Shop'), findsOneWidget);
    });

    testWidgets('has filter dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      expect(find.text('Filter by:'), findsOneWidget);
      expect(find.text('All Products'), findsOneWidget);
    });

    testWidgets('has sort dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      expect(find.text('Sort by:'), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('filter dropdown shows all options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      // Tap the filter dropdown
      await tester.tap(find.text('All Products'));
      await tester.pumpAndSettle();

      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('Portsmouth City Collection'), findsOneWidget);
      expect(find.text('University Merch'), findsOneWidget);
      expect(find.text('Signature Range'), findsOneWidget);
      expect(find.text('Essential Range'), findsOneWidget);
    });

    testWidgets('sort dropdown shows all options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShopPage(),
        ),
      );

      // Tap the sort dropdown
      await tester.tap(find.text('Featured'));
      await tester.pumpAndSettle();

      expect(find.text('Alphabetically, A-Z'), findsOneWidget);
      expect(find.text('Alphabetically, Z-A'), findsOneWidget);
      expect(find.text('Price, Low to High'), findsOneWidget);
      expect(find.text('Price, High to Low'), findsOneWidget);
    });
  });
}
