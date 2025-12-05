import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/about_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('AboutPage', () {
    testWidgets('renders with scrollable content', (WidgetTester tester) async {
      setupDesktopViewportWithReset(tester);

      await tester.pumpWidget(createTestApp(const AboutPage()));

      expect(find.byType(AboutPage), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });
}
