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
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Union Shop', style: TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF4d2963),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/shop'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Shop', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/print-shack'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Print', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/sale'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Sale', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('About', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
      ), // Close AppBar
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section (keep this)
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.network(
                      'https://example.com/your-background-image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.black26,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Content in the hero section
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discover the',
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Best Products',
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/shop');
                          },
                          child: const Text('Shop Now'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            backgroundColor: const Color(0xFF4d2963),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section (keep this)
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Featured Products',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: 'Product ${index + 1}',
                          price: '\$${(index + 1) * 10}',
                          imageUrl: 'https://example.com/product${index + 1}-image.jpg',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Footer (keep this)
            Container(
              color: const Color(0xFF4d2963),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Union Shop',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your one-stop shop for the best products',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/about'),
                        child: const Text('About Us', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/contact'),
                        child: const Text('Contact', style: TextStyle(color: Colors.white)),
                      ),
                    ],
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        automaticallyImplyLeading: false, // Add this line
      ),
      body: Center(child: Text('Shop Page')),
    );
  }
}

class PrintShackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print Shack'),
        automaticallyImplyLeading: false, // Add this line
      ),
      body: Center(child: Text('Print Shack Page')),
    );
  }
}

class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale'),
        automaticallyImplyLeading: false, // Add this line
      ),
      body: Center(child: Text('Sale Page')),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        automaticallyImplyLeading: false, // Add this line
      ),
      body: Center(child: Text('About Page')),
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
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF4d2963),
        automaticallyImplyLeading: false, // Removes back arrow
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/shop'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Shop', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/print-shack'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Print', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/sale'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('Sale', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: const Size(40, 36),
            ),
            child: const Text('About', style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
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
              child: const Text(
                'Placeholder Footer',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
