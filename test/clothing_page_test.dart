import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/clothing_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('ClothingPage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClothingPage(),
        ),
      );

      expect(find.text('Clothing'), findsOneWidget);
    });

    testWidgets('has filter and sort dropdowns', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClothingPage(),
        ),
      );

      expect(find.text('Filter by:'), findsOneWidget);
      expect(find.text('Sort by:'), findsOneWidget);
    });

    testWidgets('filter dropdown has correct options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClothingPage(),
        ),
      );

      // Tap the filter dropdown to open it
      await tester.tap(find.text('All Products'));
      await tester.pumpAndSettle();

      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('UPSU'), findsOneWidget);
    });

    testWidgets('sort dropdown has all sorting options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClothingPage(),
        ),
      );

      // Tap sort dropdown
      await tester.tap(find.text('Featured'));
      await tester.pumpAndSettle();

      expect(find.text('Best Selling'), findsOneWidget);
      expect(find.text('Alphabetically, A-Z'), findsOneWidget);
      expect(find.text('Alphabetically, Z-A'), findsOneWidget);
      expect(find.text('Price, Low to High'), findsOneWidget);
      expect(find.text('Price, High to Low'), findsOneWidget);
      expect(find.text('Date, Old to New'), findsOneWidget);
      expect(find.text('Date, New to Old'), findsOneWidget);
    });

    testWidgets('has pagination controls', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClothingPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Look for pagination elements
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}
