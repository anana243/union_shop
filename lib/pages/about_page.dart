import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
            ElevatedButton(
              onPressed: () async {
                final ref = FirebaseStorage.instance.ref().child('Untitled.png'); // change if in a folder
                final url = await ref.getDownloadURL();
                // ignore: avoid_print
                print('Storage URL: $url');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Printed URL to console')));
              },
              child: const Text('Get image URL from Storage'),
            ),
          ],
        ),
      ),
    );
  }
}