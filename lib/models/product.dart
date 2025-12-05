/// Represents a product sold in the Union Shop.
/// 
/// Contains product metadata including title, pricing, image URLs, and a slug
/// for routing and SEO purposes.
class Product {
  final String id;
  final String title;
  final String imageUrl;
  final String? imageAsset;
  final double price;
  final String slug;
  final String subtitle;

  const Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.imageAsset,
    required this.price,
    required this.slug,
    this.subtitle = '',
  });

  /// Creates a [Product] from Firestore document data.
  /// 
  /// Handles price type conversion (int to double) and provides
  /// safe defaults for missing fields.
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      title: map['title'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      imageAsset: map['imageAsset'] as String?,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] as num?)?.toDouble() ?? 0.0,
      slug: map['slug'] as String? ?? id,
      subtitle: map['subtitle'] as String? ?? '',
    );
  }

  /// Converts this [Product] to a map for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'imageAsset': imageAsset,
      'price': price,
      'slug': slug,
      'subtitle': subtitle,
    };
  }
}
