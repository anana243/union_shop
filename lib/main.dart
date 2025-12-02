import 'package:flutter/material.dart';
import 'app_layout.dart';
import 'product_page.dart';
import 'widgets/product_tile.dart';
import 'models/product.dart';

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
        '/shop': (context) => const ShopPage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/sale': (context) => const SalePage(),
        '/about': (context) => const AboutPage(),
        '/search': (context) => const SearchPage(),
        '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
        '/refund-policy': (context) => const RefundPolicyPage(),
        '/products': (context) => const AppLayout(
              title: 'Union',
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text('All Products Page (coming soon)', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
        '/product': (context) => const ProductPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define products for each section
    const img = 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282';

    final essential = [
      const Product(title: 'Essential Hoodie', price: '£14.00', imageUrl: img, slug: 'essential-hoodie'),
      const Product(title: 'Essential Tee', price: '£13.50', imageUrl: img, slug: 'essential-tee'),
    ];

    final signature = [
      const Product(title: 'Signature Sweatshirt', price: '£22.00', imageUrl: img, slug: 'signature-sweatshirt'),
      const Product(title: 'Signature Cap', price: '£16.00', imageUrl: img, slug: 'signature-cap'),
    ];

    final city = [
      const Product(title: 'Placeholder Product 1', price: '£10.00', imageUrl: img, slug: 'city1'),
      const Product(title: 'Placeholder Product 2', price: '£15.00', imageUrl: img, slug: 'city2'),
      const Product(title: 'Placeholder Product 3', price: '£20.00', imageUrl: img, slug: 'city3'),
      const Product(title: 'Placeholder Product 4', price: '£25.00', imageUrl: img, slug: 'city4'),
    ];

    return AppLayout(
      title: 'Union',
      child: Column(
        children: [
          // Hero section (unchanged)
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

          // Products Section (centered, more spacing, slightly bigger tiles)
          Container(
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 32),

                      const Center(
                        child: Text(
                          'Essential Range — over 20% off!',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 32, // a bit more spacing
                        runSpacing: 32,
                        children: essential.map((p) => ProductTile(product: p)).toList(),
                      ),

                      const SizedBox(height: 40),

                      const Center(
                        child: Text(
                          'Signature Range',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 32,
                        runSpacing: 32,
                        children: signature.map((p) => ProductTile(product: p)).toList(),
                      ),

                      const SizedBox(height: 40),

                      const Center(
                        child: Text(
                          'Portsmouth City Collection',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cols = constraints.maxWidth >= 600 ? 2 : 1;
                          return Center( // ensure the grid is centered
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                // keep grid narrow enough to appear centered
                                maxWidth: cols == 2 ? 720 : 360,
                              ),
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: cols, // 2x2 wide, 1x4 phone
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                childAspectRatio: 0.9, // avoid overflow
                                children: city.map((p) => ProductTile(product: p)).toList(),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/products'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          ),
                          child: const Text('VIEW ALL', style: TextStyle(fontSize: 14, letterSpacing: 1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple pages (unchanged functionality, using AppLayout)
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Shop Page')));
}
class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Print Shack Page')));
}
class SalePage extends StatelessWidget {
  const SalePage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Sale Page')));
}
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('About Page')));
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Search Page Content')));
}
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Terms and Conditions Content')));
}
class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Refund Policy Content')));
}
