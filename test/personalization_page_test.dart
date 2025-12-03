import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/personalization_page.dart';

void main() {
  group('PersonalizationPage', () {
    testWidgets('renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('Personalization'), findsOneWidget);
    });

    testWidgets('shows selection dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('Selection'), findsOneWidget);
      expect(find.text('1 Line of Text - £3.00'), findsOneWidget);
    });

    testWidgets('shows price', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('has quantity controls', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('Quantity'), findsOneWidget);
      expect(find.byIcon(Icons.remove_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
    });

    testWidgets('has ADD TO CART button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('shows notice with info icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('Note'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('shows text input for text options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('Personalization Text'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('quantity increases on plus button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PersonalizationPage(),
        ),
      );

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });
  });
}
