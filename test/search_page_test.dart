import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/search_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('SearchPage', () {
    testWidgets('renders with search field', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('has search input field', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      await tester.pump();
      
      // Look for search-related widgets
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('accepts text input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      // Find a TextField and enter text
      final textField = find.byType(TextField).first;
      await tester.tap(textField);
      await tester.enterText(textField, 'test product');
      
      expect(find.text('test product'), findsWidgets);
    });

    testWidgets('displays search results area', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      
      // Verify the page renders without errors
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
