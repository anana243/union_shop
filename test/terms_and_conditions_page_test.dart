import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/terms_and_conditions_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('TermsAndConditionsPage', () {
    testWidgets('renders with scrollable content', (WidgetTester tester) async {
      setupDesktopViewportWithReset(tester);

      await tester.pumpWidget(createTestApp(const TermsAndConditionsPage()));

      expect(find.byType(TermsAndConditionsPage), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });
}
