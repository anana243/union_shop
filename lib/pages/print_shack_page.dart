import 'package:flutter/material.dart';
import '../app_layout.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner image with title overlay
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 3.5, // wide banner
                child: Image.network(
                  'https://images.unsplash.com/photo-1578500494198-246f612d03b3?q=80&w=1600&auto=format&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.black.withOpacity(0.35),
                    child: const Text(
                      'UNION PRINT SHACK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Custom printing for garments and gifts. Bring your ideas to life with the Union Print Shack.',
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
