import 'package:flutter/material.dart';
import '../app_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('About Page')));
}

ElevatedButton(
  onPressed: () async {
    final repo = ProductRepository();
    await repo.seedSample();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sample products seeded')));
    }
  },
  child: const Text('Seed sample products'),
),