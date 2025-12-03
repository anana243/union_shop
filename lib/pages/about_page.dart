import 'package:flutter/material.dart';
import '../services/product_repository.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('About Union Shop'),
            const SizedBox(height: 16),
            // TEMP: Seed sample products (remove after first run)
            ElevatedButton(
              onPressed: () async {
                final repo = ProductRepository();
                await repo.seedSample();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sample products seeded')),
                );
              },
              child: const Text('Seed sample products'),
            ),
          ],
        ),
      ),
    );
  }
}