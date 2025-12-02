import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/shop': (context) => ShopPage(),
        '/print-shack': (context) => PrintShackPage(),
        '/sale': (context) => SalePage(),
        '/about': (context) => AboutPage(),
        '/search': (context) => SearchPage(),
        '/terms-and-conditions': (context) => TermsAndConditionsPage(),
        '/refund-policy': (context) => RefundPolicyPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Column(
        children: [
          // Hero Section
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  top: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Placeholder Hero Title',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "This is placeholder text for the hero section.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'BROWSE PRODUCTS',
                          style: TextStyle(fontSize: 14, letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Products Section
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const Text(
                    'PRODUCTS SECTION',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 48,
                    children: const [
                      ProductCard(
                        title: 'Placeholder Product 1',
                        price: '£10.00',
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      ),
                      ProductCard(
                        title: 'Placeholder Product 2',
                        price: '£15.00',
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      ),
                      ProductCard(
                        title: 'Placeholder Product 3',
                        price: '£20.00',
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      ),
                      ProductCard(
                        title: 'Placeholder Product 4',
                        price: '£25.00',
                        imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Shop Page Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class PrintShackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Print Shack Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Sale Page Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('About Page Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Search Page Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Terms and Conditions Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class RefundPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      title: 'Union',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('Refund Policy Content', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

// Add this new widget after UnionShopApp
class AppLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const AppLayout({
    super.key,
    required this.child,
    this.title = 'Union Shop',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: const Color(0xFF4d2963),
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              // Union title on the left
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Centered navigation buttons
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(50, 40),
                      ),
                      child: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/shop'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(50, 40),
                      ),
                      child: const Text('Shop', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/print-shack'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        minimumSize: const Size(50, 40),
                      ),
                      child: const Text('Print', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/sale'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(50, 40),
                      ),
                      child: const Text('Sale', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/about'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(50, 40),
                      ),
                      child: const Text('About', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            child, // This is the changing content
            // Footer (always visible)
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left section - Opening Hours
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OPENING HOURS',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Winter Break Closure Dates',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Closing 4:00 PM 19/12/2025',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Reopening 10:00 AM 05/01/2026',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Last Post Date: 12:00 PM on 18/12/2025',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '--------------------------------',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '(Term Time)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Monday - Friday 10:00 AM - 4:00 PM',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Outside of Term Time / Consolidation Weeks',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Monday to Friday 10:00 AM to 3:00 PM',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Purchase Online 24/7',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Middle section - Help and Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'HELP AND INFORMATION',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/search'),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/terms-and-conditions'),
                          child: const Text(
                            'Terms and Conditions',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/refund-policy'),
                          child: const Text(
                            'Refund Policy',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right section - Placeholder for now
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Right Section',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
