import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartService', () {
    late CartService cartService;

    setUp(() {
      cartService = CartService.instance;
      cartService.clear(); // Reset before each test
    });

    tearDown(() {
      cartService.clear();
    });

    test('singleton instance returns same instance', () {
      final instance1 = CartService.instance;
      final instance2 = CartService.instance;
      expect(identical(instance1, instance2), isTrue);
    });

    test('add product to cart increases count', () {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      cartService.add(product);
      expect(cartService.itemCount, equals(1));
    });

    test('add same product multiple times increases quantity', () {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      cartService.add(product);
      cartService.add(product);
      cartService.add(product);

      expect(cartService.itemCount, equals(3));
      final items = cartService.items;
      expect(items.length, equals(1));
      expect(items.first.quantity, equals(3));
    });

    test('remove product from cart decreases quantity', () {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      cartService.add(product);
      cartService.add(product);
      cartService.remove(product);

      expect(cartService.itemCount, equals(1));
    });

    test('remove last item removes product from cart', () {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      cartService.add(product);
      cartService.remove(product);

      expect(cartService.itemCount, equals(0));
      expect(cartService.items.isEmpty, isTrue);
    });

    test('total calculates correct sum', () {
      const product1 = Product(
        id: '1',
        title: 'Product 1',
        imageUrl: 'https://example.com/1.jpg',
        price: 10.0,
        slug: 'product-1',
      );

      const product2 = Product(
        id: '2',
        title: 'Product 2',
        imageUrl: 'https://example.com/2.jpg',
        price: 20.0,
        slug: 'product-2',
      );

      cartService.add(product1);
      cartService.add(product1);
      cartService.add(product2);

      expect(cartService.total, equals(40.0)); // 2*10 + 1*20
    });

    test('clear empties the cart', () {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      cartService.add(product);
      cartService.add(product);
      expect(cartService.itemCount, equals(2));

      cartService.clear();
      expect(cartService.itemCount, equals(0));
      expect(cartService.items.isEmpty, isTrue);
    });

    test('stream notifies listeners on cart changes', () async {
      const product = Product(
        id: '1',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 10.0,
        slug: 'test',
      );

      expectLater(
        cartService.stream,
        emitsInOrder([
          isA<List>().having((l) => l.length, 'length', 1),
          isA<List>().having((l) => l.length, 'length', 0),
        ]),
      );

      cartService.add(product);
      await Future.delayed(const Duration(milliseconds: 10));
      cartService.clear();
    });
  });
}
