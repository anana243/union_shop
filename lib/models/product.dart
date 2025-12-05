/// Represents a product sold in the Union Shop.
/// 
/// Contains product metadata including title, pricing, image URLs, and a slug
/// for routing and SEO purposes.
class Product {
  /// Unique identifier for the product.
  final String id;
  
  /// Display name of the product.
  final String title;
  
  /// URL for the product image (typically from external CDN).
  final String imageUrl;
  
  /// Optional local asset path for the product image.
  final String? imageAsset;
  
  /// Price in GBP (£).
  final double price;
  
  /// URL-friendly identifier used for routing and SEO.
  final String slug;
  
  /// Additional product description or category info.
  final String subtitle;

  /// Creates a [Product].
  ///
  /// All parameters except [imageAsset] and [subtitle] are required.
  /// [subtitle] defaults to empty string if not provided.
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
