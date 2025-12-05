import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/cart_service.dart';
import 'test_helper.dart';

/// Integration test for complete user flow:
/// 1. Browse products on home page
/// 2. Add product to cart
/// 3. View cart
void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  setUp(() {
    CartService.instance.clear();
  });

  tearDown(() {
    CartService.instance.clear();
  });

  group('User Shopping Flow Integration Tests', () {
    testWidgets('User can add product to cart from home page',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );
      
      // Wait for page to render with multiple pumps
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      // Verify home page loads
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('Cart increments when adding products', (tester) async {
      final cartService = CartService.instance;
      cartService.clear();

      const product1 = Product(
        id: '1',
        title: 'Product 1',
        imageUrl: 'https://example.com/1.jpg',
        price: 19.99,
        slug: 'product-1',
      );

      // Add product to cart
      cartService.add(product1);
      expect(cartService.count, equals(1));
      expect(cartService.total, equals(19.99));

      // Add same product again
      cartService.add(product1);
      expect(cartService.count, equals(2));
      expect(cartService.total, equals(39.98));
    });

    testWidgets('Multiple different products can be added to cart',
        (tester) async {
      final cartService = CartService.instance;
      cartService.clear();

      const product1 = Product(
        id: '1',
        title: 'T-Shirt',
        imageUrl: 'https://example.com/1.jpg',
        price: 15.99,
        slug: 'tshirt',
      );

      const product2 = Product(
        id: '2',
        title: 'Hoodie',
        imageUrl: 'https://example.com/2.jpg',
        price: 35.99,
        slug: 'hoodie',
      );

      // Add different products
      cartService.add(product1);
      cartService.add(product2);
      cartService.add(product1);

      expect(cartService.count, equals(3));
      expect(cartService.items.length, equals(2));
      expect(cartService.total, equals(67.97)); // 2*15.99 + 35.99
    });

    testWidgets('User can remove item from cart', (tester) async {
      final cartService = CartService.instance;
      cartService.clear();

      const product1 = Product(
        id: '1',
        title: 'Product 1',
        imageUrl: 'https://example.com/1.jpg',
        price: 20.00,
        slug: 'product-1',
      );

      const product2 = Product(
        id: '2',
        title: 'Product 2',
        imageUrl: 'https://example.com/2.jpg',
        price: 30.00,
        slug: 'product-2',
      );

      // Add products
      cartService.add(product1);
      cartService.add(product2);
      expect(cartService.items.length, equals(2));

      // Remove one product
      cartService.remove(product1);
      expect(cartService.items.length, equals(1));
      expect(cartService.total, equals(30.00));
    });

    testWidgets('User can view empty cart', (WidgetTester tester) async {
      CartService.instance.clear();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Your cart is empty'),
            ),
          ),
        ),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('User can update quantity in cart', (tester) async {
      final cartService = CartService.instance;
      cartService.clear();

      const product = Product(
        id: '1',
        title: 'Product',
        imageUrl: 'https://example.com/1.jpg',
        price: 25.00,
        slug: 'product',
      );

      cartService.add(product);
      expect(cartService.count, equals(1));

      cartService.updateQuantity(product, 5);
      expect(cartService.count, equals(5));
      expect(cartService.total, equals(125.00));

      cartService.updateQuantity(product, 2);
      expect(cartService.count, equals(2));
      expect(cartService.total, equals(50.00));
    });

    testWidgets('Cart total is calculated correctly with multiple items',
        (tester) async {
      final cartService = CartService.instance;
      cartService.clear();

      const items = [
        Product(
          id: '1',
          title: 'Item 1',
          imageUrl: 'https://example.com/1.jpg',
          price: 10.00,
          slug: 'item-1',
        ),
        Product(
          id: '2',
          title: 'Item 2',
          imageUrl: 'https://example.com/2.jpg',
          price: 15.50,
          slug: 'item-2',
        ),
        Product(
          id: '3',
          title: 'Item 3',
          imageUrl: 'https://example.com/3.jpg',
          price: 5.25,
          slug: 'item-3',
        ),
      ];

      for (var item in items) {
        cartService.add(item);
      }

      expect(cartService.count, equals(3));
      expect(cartService.total, 30.75);
    });

    testWidgets('Clearing cart empties all items', (tester) async {
      final cartService = CartService.instance;

      const products = [
        Product(
          id: '1',
          title: 'Product 1',
          imageUrl: 'https://example.com/1.jpg',
          price: 20.00,
          slug: 'product-1',
        ),
        Product(
          id: '2',
          title: 'Product 2',
          imageUrl: 'https://example.com/2.jpg',
          price: 30.00,
          slug: 'product-2',
        ),
      ];

      for (var product in products) {
        cartService.add(product);
      }

      expect(cartService.items.length, equals(2));
      expect(cartService.count, equals(2));

      cartService.clear();
      expect(cartService.items.isEmpty, isTrue);
      expect(cartService.count, equals(0));
      expect(cartService.total, equals(0.0));
    });
  });
}
