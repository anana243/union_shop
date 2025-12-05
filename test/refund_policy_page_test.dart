import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/refund_policy_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('RefundPolicyPage', () {
    testWidgets('renders with scrollable content', (WidgetTester tester) async {
      setupDesktopViewportWithReset(tester);

      await tester.pumpWidget(createTestApp(const RefundPolicyPage()));

      expect(find.byType(RefundPolicyPage), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });
}
