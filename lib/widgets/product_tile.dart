import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool _hover = false;

  String get priceLabel => '£${widget.product.price.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('Product imageUrl: ${widget.product.imageUrl}');
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 700;
    final maxTileWidth = isMobile ? 180.0 : 220.0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxTileWidth),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: _hover
              ? [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 3))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[300], child: const Icon(Icons.image_not_supported, size: 42)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    priceLabel,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF4d2963)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}