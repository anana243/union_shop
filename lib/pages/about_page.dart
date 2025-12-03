import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('About Page')));

  Scaffold(
    // ...existing code...
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ...existing code...

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

          // ...existing code...
        ],
      ),
    );
  }
}