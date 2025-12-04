// ignore_for_file: deprecated_member_use

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
    const double maxTileWidth = 220.0; // standardized width across pages

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, '/product', arguments: widget.product),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxTileWidth),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: _hover
                  ? [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ]
                  : [],
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: widget.product.imageAsset != null
                        ? Image.asset(
                            widget.product.imageAsset!,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                            errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported, size: 42)),
                          )
                        : Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                            errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported, size: 42)),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(widget.product.title,
                            style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        if (widget.product.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            widget.product.subtitle,
                              style: const TextStyle(
                                fontSize: 12, color: Colors.black87),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 6),
                        Text(priceLabel,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4d2963))),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
