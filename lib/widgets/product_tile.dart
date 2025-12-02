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

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/product', arguments: p.toArgs()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Slightly larger but bounded image, centered feel
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 340,
                  maxHeight: 260,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        p.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                      if (_hover)
                        Container(
                          color: Colors.black.withOpacity(0.15),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                p.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15, // slightly bigger
                  color: Colors.black,
                  decoration: _hover ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                p.price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}