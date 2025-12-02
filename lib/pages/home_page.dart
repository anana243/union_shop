import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Hero
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  top: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Placeholder Hero Title', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 16),
                      const Text('This is placeholder text for the hero section.', style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text('BROWSE PRODUCTS', style: TextStyle(fontSize: 14, letterSpacing: 1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Products
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

                      const Center(child: Text('Essential Range — over 20% off!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 32,
                        runSpacing: 32,
                        children: essential.map((p) => ProductTile(product: p)).toList(),
                      ),

                      const SizedBox(height: 40),

                      const Center(child: Text('Signature Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 32,
                        runSpacing: 32,
                        children: signature.map((p) => ProductTile(product: p)).toList(),
                      ),

                      const SizedBox(height: 40),

                      const Center(child: Text('Portsmouth City Collection', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cols = constraints.maxWidth >= 600 ? 2 : 1;
                          return Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: cols == 2 ? 760 : 380),
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: cols,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                childAspectRatio: 0.9,
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
```

````dart
// filepath: c:\Users\anast\Desktop\prog\union_shop\lib\pages\shop_page.dart
import 'package:flutter/material.dart';
import '../app_layout.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Shop Page')));
}