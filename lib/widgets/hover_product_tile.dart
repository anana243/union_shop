import 'package:flutter/material.dart';

class HoverProductTile extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final VoidCallback onTap;

  const HoverProductTile({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<HoverProductTile> createState() => _HoverProductTileState();
}

class _HoverProductTileState extends State<HoverProductTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 220),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.imageUrl,
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
                      if (_hover) Container(color: Colors.black.withOpacity(0.15)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  decoration: _hover ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
              const SizedBox(height: 6),
              Text(widget.price, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}