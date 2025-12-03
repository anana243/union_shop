import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/cart_page.dart';

void main() {
  group('CartPage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CartPage(),
        ),
      );

      expect(find.text('Your Cart'), findsOneWidget);
    });

    testWidgets('shows empty cart message when cart is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CartPage(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('has continue shopping button when empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CartPage(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
    });
  });
}
