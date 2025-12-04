import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../constants.dart';

class AboutPrintShackPage extends StatelessWidget {
  const AboutPrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: Image.network(
                kHeroImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'The Union Print Shack',
                        style:
                            TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Make it yours with simple, transparent pricing — no surprises. Personalize clothing and merchandise with custom text or logos, then check our Terms & Conditions for personalization guidelines.',
                        style: TextStyle(fontSize: 15, height: 1.6),
                      ),
                      const SizedBox(height: 28),
                      const Text('Our Services',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      _buildServiceItem(
                        'Personalized Text',
                        'Add 1–4 lines of text in a variety of styles.',
                      ),
                      const SizedBox(height: 10),
                      _buildServiceItem(
                        'Logo Printing',
                        'Small or large logo placement for garments and gifts.',
                      ),
                      const SizedBox(height: 10),
                      _buildServiceItem(
                        'Helpful Guidance',
                        'Not sure what to choose? We\'ll help you get it right.',
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF4d2963), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
