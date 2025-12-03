import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_helper.dart';

import 'package:union_shop/pages/product_page.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  testWidgets('ProductPage displays provided args', (tester) async {
    // Set larger viewport so content isn't clipped
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    final app = MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductPage(),
                      settings: const RouteSettings(arguments: {
                        'title': 'Test Product',
                        'price': '£99.99',
                        'imageUrl': 'https://example.com/image.png',
                      }),
                    ),
                  );
                },
                child: const Text('Go'),
              ),
            ),
          );
        },
      ),
    );

    await tester.pumpWidget(app);
    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£99.99'), findsOneWidget);
    expect(find.text('Details coming soon...'), findsOneWidget);
  });
}
