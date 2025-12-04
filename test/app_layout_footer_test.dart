import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/app_layout.dart';
import 'package:union_shop/pages/search_page.dart';
import 'package:union_shop/pages/terms_and_conditions_page.dart';
import 'package:union_shop/pages/refund_policy_page.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  Widget app() => MaterialApp(
        routes: {
          '/': (context) =>
              const AppLayout(title: 'Union', child: SizedBox.shrink()),
          '/search': (context) => const SearchPage(),
          '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
          '/refund-policy': (context) => const RefundPolicyPage(),
        },
        initialRoute: '/',
      );

  testWidgets('Footer has Terms & Conditions link', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(app());
    await tester.pump(const Duration(milliseconds: 300));

    // Just verify the link exists in the footer
    expect(find.text('Terms & Conditions'), findsOneWidget);
    expect(find.text('Refund Policy'), findsOneWidget);
  });
}
