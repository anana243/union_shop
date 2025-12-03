import 'package:flutter/material.dart';
import '../app_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('About Union Shop', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                Text('We provide clothing, merchandise, and personalized gifts.', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}