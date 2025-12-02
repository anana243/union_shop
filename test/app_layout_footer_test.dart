import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/app_layout.dart';
import 'package:union_shop/pages/search_page.dart';
import 'package:union_shop/pages/terms_and_conditions_page.dart';
import 'package:union_shop/pages/refund_policy_page.dart';

void main() {
  setupTests();

  Widget app() => MaterialApp(
    routes: {
      '/': (context) => const AppLayout(title: 'Union', child: SizedBox.shrink()),
      '/search': (context) => const SearchPage(),
      '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
      '/refund-policy': (context) => const RefundPolicyPage(),
    },
    initialRoute: '/',
  );

  testWidgets('Footer links navigate', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(app());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Scroll to footer
    await tester.scrollUntilVisible(
      find.text('HELP AND INFORMATION'),
      100.0,
      scrollable: find.byType(Scrollable).first,
    );

    // Tap Search (HoverText wraps it, so we tap by text)
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(find.text('Search Page Content'), findsOneWidget);
    Navigator.of(tester.element(find.text('Search Page Content'))).pop();
    await tester.pumpAndSettle();

    // Scroll footer back into view after navigation
    await tester.scrollUntilVisible(
      find.text('HELP AND INFORMATION'),
      100.0,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(find.text('Terms and Conditions'));
    await tester.pumpAndSettle();
    expect(find.text('Terms and Conditions Content'), findsOneWidget);
    Navigator.of(tester.element(find.text('Terms and Conditions Content'))).pop();
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('HELP AND INFORMATION'),
      100.0,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.tap(find.text('Refund Policy'));
    await tester.pumpAndSettle();
    expect(find.text('Refund Policy Content'), findsOneWidget);
  });
}