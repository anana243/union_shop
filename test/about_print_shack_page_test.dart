import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/about_print_shack_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('AboutPrintShackPage', () {
    testWidgets('renders with scrollable content', (WidgetTester tester) async {
      setupDesktopViewportWithReset(tester);

      await tester.pumpWidget(createTestApp(const AboutPrintShackPage()));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.byType(AboutPrintShackPage), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });
}
