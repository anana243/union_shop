import 'package:flutter/material.dart';
import '../app_layout.dart';

class AboutPrintShackPage extends StatelessWidget {
  const AboutPrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Print Shack',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Print Shack, your one-stop shop for custom printing and personalization services!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                const Text(
                  'At Print Shack, we specialize in bringing your creative visions to life. Whether you\'re looking to personalize your clothing, create custom merchandise, or add a unique touch to your accessories, we\'ve got you covered.',
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Our Services',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildServiceItem(
                  'Custom Text Printing',
                  'Add personalized text to your garments with our high-quality printing service. Choose from multiple lines and font sizes.',
                ),
                const SizedBox(height: 12),
                _buildServiceItem(
                  'Logo Printing',
                  'Print your logo or design on any item. We offer both small and large logo options to suit your needs.',
                ),
                const SizedBox(height: 12),
                _buildServiceItem(
                  'Design Consultation',
                  'Not sure what you want? Our team is here to help you create the perfect design for your personalized items.',
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4d2963).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Quality Guarantee',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'We use only the highest quality materials and printing techniques to ensure your personalized items look great and last long. Every item is carefully crafted and inspected before shipping.',
                        style: TextStyle(fontSize: 16, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
