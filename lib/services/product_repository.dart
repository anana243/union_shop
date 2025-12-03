import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductRepository {
  final FirebaseFirestore _db;
  ProductRepository({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _col => _db.collection('products');

  Future<List<Product>> listByCollection(String collection) async {
    final q = await _col.where('collections', arrayContains: collection).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  Future<List<Product>> listFeatured() async {
    final q = await _col.where('featured', isEqualTo: true).limit(12).get();
    return q.docs.map((d) => Product.fromMap(d.id, d.data())).toList();
  }

  Future<Product?> getBySlug(String slug) async {
    final q = await _col.where('slug', isEqualTo: slug).limit(1).get();
    if (q.docs.isEmpty) return null;
    final d = q.docs.first;
    return Product.fromMap(d.id, d.data());
  }

  // Seed sample products (safe to run once)
  Future<void> seedSample() async {
    final batch = _db.batch();

    final samples = [
      {
        'title': 'Essential Hoodie',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'price': 14.00,
        'slug': 'essential-hoodie',
        'collections': ['essential'],
        'featured': true,
      },
      {
        'title': 'Essential Tee',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'price': 13.50,
        'slug': 'essential-tee',
        'collections': ['essential'],
        'featured': true,
      },
      {
        'title': 'Signature Sweatshirt',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'price': 22.00,
        'slug': 'signature-sweatshirt',
        'collections': ['signature'],
        'featured': true,
      },
      {
        'title': 'Signature Cap',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'price': 16.00,
        'slug': 'signature-cap',
        'collections': ['signature'],
        'featured': true,
      },
      {
        'title': 'City Magnet',
        'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
        'price': 10.00,
        'slug': 'city-magnet',
        'collections': ['city'],
        'featured': false,
      },
    ];

    for (final s in samples) {
      final doc = _col.doc(s['slug'] as String);
      batch.set(doc, s);
    }

    await batch.commit();
  }
}