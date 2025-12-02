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
        toolbarHeight: 56, // Standard mobile height
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8), // Reduce padding
              minimumSize: Size(50, 40), // Smaller button size
            ),
            child: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/shop'); // route is lowercase
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size(50, 40),
            ),
            child: const Text('Shop', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5)), // display is capitalized
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/print-shack'); // route is lowercase with hyphen
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 6),
              minimumSize: Size(50, 40),
            ),
            child: const Text('Print', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5)), // display as you want
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sale'); // Add this
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size(50, 40),
            ),
            child: const Text('Sale', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5)), // display with exclamation
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about'); // Add this
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size(50, 40),
            ),
            child: const Text('About', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5)), // display is capitalized
          ),
        ],
      ), // Close AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Union Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop');
              },
              child: Text('BROWSE PRODUCTS'),
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
      appBar: AppBar(title: Text('Shop')),
      body: Center(child: Text('Shop Page')),
    );
  }
}

class PrintShackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Print Shack')),
      body: Center(child: Text('Print Shack Page')),
    );
  }
}

class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sale')),
      body: Center(child: Text('Sale Page')),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(child: Text('About Page')),
    );
  }
}
