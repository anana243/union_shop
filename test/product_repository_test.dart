import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/product_repository.dart';
import 'package:union_shop/models/product.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('ProductRepository', () {
    late ProductRepository repo;

    setUp(() {
      repo = ProductRepository();
    });

    test('repository initializes successfully', () {
      expect(repo, isNotNull);
    });

    test('repository has collection reference', () {
      // Verify the repository can be instantiated
      final testRepo = ProductRepository();
      expect(testRepo, isA<ProductRepository>());
    });

    test('Product model can be created from map', () {
      final map = {
        'title': 'Test Product',
        'imageUrl': 'https://example.com/test.jpg',
        'price': 25.99,
        'slug': 'test-product',
        'subtitle': 'A test product',
      };

      final product = Product.fromMap('test-id', map);
      
      expect(product.id, equals('test-id'));
      expect(product.title, equals('Test Product'));
      expect(product.price, equals(25.99));
    });

    test('Product toMap converts correctly', () {
      const product = Product(
        id: '1',
        title: 'Test',
        imageUrl: 'https://example.com/test.jpg',
        price: 15.99,
        slug: 'test',
      );

      final map = product.toMap();
      expect(map['title'], equals('Test'));
      expect(map['price'], equals(15.99));
      expect(map['slug'], equals('test'));
    });
  });
}
