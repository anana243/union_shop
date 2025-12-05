import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/pages/product_page.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  testWidgets('ProductPage renders without errors', (tester) async {
    setupDesktopViewportWithReset(tester);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return const Center(child: ProductPage());
            },
          ),
        ),
      ),
    );

    // Verify the widget can be created and rendered
    expect(find.byType(ProductPage), findsOneWidget);
  });
}
