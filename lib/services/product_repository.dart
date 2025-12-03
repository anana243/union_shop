import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> ping() async {
    await _db.collection('_ping').doc('web').set({'ok': true});
    final d = await _db.collection('_ping').doc('web').get();
    return d.exists;
  }

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('products');

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

  Future<List<Product>> listFeatured() async {
    final q = await _col.where('featured', isEqualTo: true).limit(12).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  Future<List<Product>> listAll({int limit = 100}) async {
    final q = await _col.limit(limit).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  Future<Product?> getBySlug(String slug) async {
    final q = await _col.where('slug', isEqualTo: slug).limit(1).get();
    if (q.docs.isEmpty) return null;
    final d = q.docs.first;
    return Product.fromMap(d.id, d.data());
  }
}
