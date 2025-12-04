import 'package:flutter/material.dart';
import '../app_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 200,
        ),
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Us',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                SizedBox(height: 12),
                Text(
                  'Welcome to the Union Shop — we\'re dedicated to offering the very best university‑branded products, with a range of clothing and merchandise available to shop all year round. We even offer an exclusive personalization service.',
                  style: TextStyle(fontSize: 15, height: 1.6),
                ),
                SizedBox(height: 12),
                Text(
                  'All online purchases are available for delivery or in‑store collection. We hope you enjoy your products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us.',
                  style: TextStyle(fontSize: 15, height: 1.6),
                ),
                SizedBox(height: 12),
                Text('Happy shopping,\nThe Union Shop team',
                    style: TextStyle(fontSize: 15, height: 1.6)),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
