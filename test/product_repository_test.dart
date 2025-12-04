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

    test('listByCollection returns Future<List<Product>>', () async {
      final result = repo.listByCollection('test_collection');
      expect(result, isA<Future<List<Product>>>());
      // Don't await - just verify the type since Firebase isn't populated
    }, skip: true); // Skip - Firebase not properly mocked for data queries

    test('listAll returns Future<List<Product>>', () async {
      final result = repo.listAll();
      expect(result, isA<Future<List<Product>>>());
      // Don't await - just verify the type since Firebase isn't populated
    }, skip: true); // Skip - Firebase not properly mocked for data queries

    test('listFeatured returns Future<List<Product>>', () async {
      final result = repo.listFeatured();
      expect(result, isA<Future<List<Product>>>());
      // Don't await - just verify the type since Firebase isn't populated
    }, skip: true); // Skip - Firebase not properly mocked for data queries

    test('getBySlug returns Future<Product?>', () async {
      final result = repo.getBySlug('test-slug');
      expect(result, isA<Future<Product?>>());
      // Don't await - just verify the type since Firebase isn't populated
    }, skip: true); // Skip - Firebase not properly mocked for data queries
  });
}
