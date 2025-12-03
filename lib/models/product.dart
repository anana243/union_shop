class Product {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String slug;

  const Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.slug,
  });

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      title: map['title'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] as num?)?.toDouble() ?? 0.0,
      slug: map['slug'] as String? ?? id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'slug': slug,
    };
  }
}