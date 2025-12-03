// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_grid.dart';

void main() {
  group('ProductGrid', () {
    final testProducts = [
      const Product(
        id: '1',
        title: 'Test Product 1',
        imageUrl: 'https://example.com/1.jpg',
        price: 10.0,
        slug: 'test-1',
      ),
      const Product(
        id: '2',
        title: 'Test Product 2',
        imageUrl: 'https://example.com/2.jpg',
        price: 20.0,
        slug: 'test-2',
      ),
    ];

    testWidgets('renders Wrap layout by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(products: testProducts),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('renders GridView when twoColumnGrid is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(products: testProducts, twoColumnGrid: true),
          ),
        ),
      );

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('displays all products in Wrap layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(products: testProducts),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Product 1'), findsOneWidget);
      expect(find.text('Test Product 2'), findsOneWidget);
    });

    testWidgets('displays all products in GridView layout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(products: testProducts, twoColumnGrid: true),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Product 1'), findsOneWidget);
      expect(find.text('Test Product 2'), findsOneWidget);
    });

    testWidgets('handles empty product list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductGrid(products: const []),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
    });
  });
}
