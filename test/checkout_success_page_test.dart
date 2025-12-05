import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/checkout_success_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('CheckoutSuccessPage', () {
    testWidgets('renders success page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CheckoutSuccessPage(),
        ),
      );

      expect(find.byType(CheckoutSuccessPage), findsOneWidget);
    });

    testWidgets('displays success message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CheckoutSuccessPage(),
        ),
      );

      // Look for success indicators
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('has continue shopping button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CheckoutSuccessPage(),
        ),
      );

      expect(find.byType(ElevatedButton), findsWidgets);
    });
  });
}
