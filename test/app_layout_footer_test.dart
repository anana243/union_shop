import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/app_layout.dart';
import 'package:union_shop/pages/search_page.dart';
import 'package:union_shop/pages/terms_and_conditions_page.dart';
import 'package:union_shop/pages/refund_policy_page.dart';

void main() {
  setupTests();

  Widget _app() {
    return MaterialApp(
      routes: {
        '/': (context) => const AppLayout(title: 'Union', child: SizedBox()),
        '/search': (context) => const SearchPage(),
        '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
        '/refund-policy': (context) => const RefundPolicyPage(),
      },
      initialRoute: '/',
    );
  }

  testWidgets('Footer help links navigate correctly', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pump();

    await tester.tap(find.text('Search'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Search Page Content'), findsOneWidget);
    Navigator.of(tester.element(find.text('Search Page Content'))).pop();
    await tester.pump();

    await tester.tap(find.text('Terms and Conditions'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Terms and Conditions Content'), findsOneWidget);
    Navigator.of(tester.element(find.text('Terms and Conditions Content'))).pop();
    await tester.pump();

    await tester.tap(find.text('Refund Policy'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Refund Policy Content'), findsOneWidget);
  });
}