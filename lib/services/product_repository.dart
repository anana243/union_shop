import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

/// Repository for managing product data from Firestore.
/// 
/// Handles all product queries including filtering, searching, and featured items.
/// This class abstracts the Firestore interaction layer for the application.
class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Checks if Firestore connection is working.
  /// 
  /// Writes and reads a test document to verify connectivity.
  Future<bool> ping() async {
    await _db.collection('_ping').doc('web').set({'ok': true});
    final d = await _db.collection('_ping').doc('web').get();
    return d.exists;
  }

  /// Reference to the products collection in Firestore.
  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('products');

  /// Gets all products belonging to a specific collection.
  /// 
  /// Supports both new format (array field `collections`) and legacy format
  /// (single `category` field) for backward compatibility.
  /// 
  /// Parameters:
  ///   - [collection]: The collection name to filter by (e.g., 'Clothing', 'Merchandise')
  /// 
  /// Returns a list of [Product] objects matching the collection.
  Future<List<Product>> listByCollection(String collection) async {
    // Primary: documents with array field `collections` containing the value
    final q1 = await _col.where('collections', arrayContains: collection).get();
    final byCollections = {
      for (final d in q1.docs) d.id: Product.fromMap(d.id, d.data())
    };

    // Fallback: some older docs may use a single `category` field
    final q2 = await _col.where('category', isEqualTo: collection).get();
    for (final d in q2.docs) {
      byCollections.putIfAbsent(d.id, () => Product.fromMap(d.id, d.data()));
    }

    return byCollections.values.toList();
  }

  /// Gets featured products up to a limit of 12.
  /// 
  /// Returns a list of [Product] objects marked as featured in Firestore.
  Future<List<Product>> listFeatured() async {
    final q = await _col.where('featured', isEqualTo: true).limit(12).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  /// Gets all products with an optional limit.
  /// 
  /// Parameters:
  ///   - [limit]: Maximum number of products to fetch (default: 100)
  /// 
  /// Returns a list of [Product] objects.
  Future<List<Product>> listAll({int limit = 100}) async {
    final q = await _col.limit(limit).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  /// Gets a single product by its slug (URL-friendly identifier).
  /// 
  /// Parameters:
  ///   - [slug]: The URL-friendly slug of the product
  /// 
  /// Returns a [Product] object if found, or null if not found.
  Future<Product?> getBySlug(String slug) async {
    final q = await _col.where('slug', isEqualTo: slug).limit(1).get();
    if (q.docs.isEmpty) return null;
    final d = q.docs.first;
    return Product.fromMap(d.id, d.data());
  }

  /// Searches for products by title or subtitle.
  /// 
  /// Performs client-side filtering on titles and subtitles (case-insensitive).
  /// Note: Firestore doesn't support full-text search natively, so this fetches
  /// a batch of products and filters locally.
  /// 
  /// Parameters:
  ///   - [query]: The search query string
  /// 
  /// Returns a list of matching [Product] objects, or empty list if query is empty.
  Future<List<Product>> searchProducts(String query) async {
    if (query.trim().isEmpty) return [];

    final lowercaseQuery = query.toLowerCase().trim();

    // Firestore doesn't support full-text search natively; fetch and filter
    final allProducts = await listAll(limit: 500);

    return allProducts.where((product) {
      final title = product.title.toLowerCase();
      final subtitle = product.subtitle.toLowerCase();
      return title.contains(lowercaseQuery) ||
          subtitle.contains(lowercaseQuery);
    }).toList();
  }
}
