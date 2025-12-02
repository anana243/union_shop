class Product {
  final String title;
  final String price;
  final String imageUrl;
  final String slug; // unique id for routing

  const Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.slug,
  });

  Map<String, dynamic> toArgs() => {
        'title': title,
        'price': price,
        'imageUrl': imageUrl,
        'slug': slug,
      };
}