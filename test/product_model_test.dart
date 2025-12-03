import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product', () {
    test('creates product with all fields', () {
      const product = Product(
        id: '123',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 25.99,
        slug: 'test-product',
        subtitle: 'A great test product',
      );

      expect(product.id, equals('123'));
      expect(product.title, equals('Test Product'));
      expect(product.imageUrl, equals('https://example.com/test.jpg'));
      expect(product.price, equals(25.99));
      expect(product.slug, equals('test-product'));
      expect(product.subtitle, equals('A great test product'));
    });

    test('creates product with default subtitle', () {
      const product = Product(
        id: '123',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 25.99,
        slug: 'test-product',
      );

      expect(product.subtitle, equals(''));
    });

    test('fromMap creates product from map with all fields', () {
      final map = {
        'title': 'Test Product',
        'imageUrl': 'https://example.com/test.jpg',
        'price': 25.99,
        'slug': 'test-product',
        'subtitle': 'A great test product',
      };

      final product = Product.fromMap('123', map);

      expect(product.id, equals('123'));
      expect(product.title, equals('Test Product'));
      expect(product.imageUrl, equals('https://example.com/test.jpg'));
      expect(product.price, equals(25.99));
      expect(product.slug, equals('test-product'));
      expect(product.subtitle, equals('A great test product'));
    });

    test('fromMap handles missing optional fields', () {
      final map = {
        'title': 'Test Product',
        'imageUrl': 'https://example.com/test.jpg',
        'price': 25.99,
      };

      final product = Product.fromMap('123', map);

      expect(product.slug, equals('123')); // defaults to id
      expect(product.subtitle, equals(''));
    });

    test('fromMap handles integer price', () {
      final map = {
        'title': 'Test Product',
        'imageUrl': 'https://example.com/test.jpg',
        'price': 25,
        'slug': 'test-product',
      };

      final product = Product.fromMap('123', map);

      expect(product.price, equals(25.0));
    });

    test('fromMap handles missing price', () {
      final map = {
        'title': 'Test Product',
        'imageUrl': 'https://example.com/test.jpg',
        'slug': 'test-product',
      };

      final product = Product.fromMap('123', map);

      expect(product.price, equals(0.0));
    });

    test('toMap creates map with all fields', () {
      const product = Product(
        id: '123',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 25.99,
        slug: 'test-product',
        subtitle: 'A great test product',
      );

      final map = product.toMap();

      expect(map['title'], equals('Test Product'));
      expect(map['imageUrl'], equals('https://example.com/test.jpg'));
      expect(map['price'], equals(25.99));
      expect(map['slug'], equals('test-product'));
      expect(map['subtitle'], equals('A great test product'));
    });

    test('toMap includes empty subtitle', () {
      const product = Product(
        id: '123',
        title: 'Test Product',
        imageUrl: 'https://example.com/test.jpg',
        price: 25.99,
        slug: 'test-product',
      );

      final map = product.toMap();

      expect(map['subtitle'], equals(''));
    });
  });
}
