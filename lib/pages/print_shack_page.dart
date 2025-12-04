import 'package:flutter/material.dart';
import '../app_layout.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    
    return AppLayout(
      title: 'Union',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner image with title overlay
          Stack(
            children: [
              SizedBox(
                height: isMobile ? 200 : 300,
                child: Image.network(
                  'https://images.unsplash.com/photo-1578500494198-246f612d03b3?q=80&w=1600&auto=format&fit=crop',
                  fit: BoxFit.cover,
                  width: double.infinity,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 16,
                      vertical: isMobile ? 6 : 8,
                    ),
                    color: Colors.black.withOpacity(0.35),
                    child: Text(
                      'UNION PRINT SHACK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            child: Text(
              'Custom printing for garments and gifts. Bring your ideas to life with the Union Print Shack.',
              style: TextStyle(fontSize: isMobile ? 14 : 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: isMobile ? 24 : 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),
                _ServiceTile(
                  icon: Icons.checkroom,
                  title: 'Custom Garment Printing',
                  description: 'Print your designs on t-shirts, hoodies, and more',
                  isMobile: isMobile,
                ),
                _ServiceTile(
                  icon: Icons.card_giftcard,
                  title: 'Gift Personalization',
                  description: 'Mugs, tote bags, and other unique gifts',
                  isMobile: isMobile,
                ),
                _ServiceTile(
                  icon: Icons.brush,
                  title: 'Design Services',
                  description: 'Need help? Our team can bring your ideas to life',
                  isMobile: isMobile,
                ),
                SizedBox(height: isMobile ? 24 : 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isMobile;

  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: isMobile ? 32 : 40, color: const Color(0xFF4d2963)),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
