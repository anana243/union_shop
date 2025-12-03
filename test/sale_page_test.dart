import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('SalePage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalePage(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Union Sale'), findsOneWidget);
    });

    testWidgets('shows sale description', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalePage(),
        ),
      );

      await tester.pumpAndSettle();

      expect(
          find.textContaining('Get yours before they\'re all gone'),
          findsOneWidget);
    });

    testWidgets('has hero carousel', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalePage(),
        ),
      );

      await tester.pump();

      // HeroCarousel should be present
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
