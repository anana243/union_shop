import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../widgets/product_tile.dart';
import '../widgets/hero_carousel.dart';
import '../models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _heroImageUrl = 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561';
  static const _productImageUrl = 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282';

  @override
  Widget build(BuildContext context) {
    final essential = [
      const Product(title: 'Essential Hoodie', price: '£14.00', imageUrl: _productImageUrl, slug: 'essential-hoodie'),
      const Product(title: 'Essential Tee', price: '£13.50', imageUrl: _productImageUrl, slug: 'essential-tee'),
    ];

    final signature = [
      const Product(title: 'Signature Sweatshirt', price: '£22.00', imageUrl: _productImageUrl, slug: 'signature-sweatshirt'),
      const Product(title: 'Signature Cap', price: '£16.00', imageUrl: _productImageUrl, slug: 'signature-cap'),
    ];

    final city = [
      const Product(title: 'Placeholder Product 1', price: '£10.00', imageUrl: _productImageUrl, slug: 'city1'),
      const Product(title: 'Placeholder Product 2', price: '£15.00', imageUrl: _productImageUrl, slug: 'city2'),
      const Product(title: 'Placeholder Product 3', price: '£20.00', imageUrl: _productImageUrl, slug: 'city3'),
      const Product(title: 'Placeholder Product 4', price: '£25.00', imageUrl: _productImageUrl, slug: 'city4'),
    ];

    return AppLayout(
      title: 'Union',
      child: Column(
        children: [
          HeroCarousel(imageUrl: _heroImageUrl),
          _buildProductsSection(context, essential, signature, city),
        ],
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    List<Product> essential,
    List<Product> signature,
    List<Product> city,
  ) {
    return Container(
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
                _buildProductGroup('Essential Range - over 20% off!', essential),
                const SizedBox(height: 40),
                _buildProductGroup('Signature Range', signature),
                const SizedBox(height: 40),
                _buildCityCollection('Portsmouth City Collection', city),
                const SizedBox(height: 20),
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
                const SizedBox(height: 32),
                const Center(
                  child: Text('Our Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 20),
                _OurRangeGrid(
                  items: const [
                    _RangeItem(title: 'Clothing', route: '/shop'),
                    _RangeItem(title: 'Merchandise', route: '/shop'),
                    _RangeItem(title: 'Graduation', route: '/shop'),
                    _RangeItem(title: 'Sale', route: '/sale'),
                  ],
                  imageUrl: _productImageUrl,
                ),
                const SizedBox(height: 64),
                _PersonalizeSplit(imageUrl: _productImageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityCollection(String title, List<Product> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        if (isWide) {
          return Column(
            children: [
              Center(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: products.map((p) => ProductTile(product: p)).toList(),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Center(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, i) => ProductTile(product: products[i]),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildProductGroup(String title, List<Product> products) {
    return Column(
      children: [
        Center(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 24,
          children: products.map((p) => ProductTile(product: p)).toList(),
        ),
      ],
    );
  }
}

class _OurRangeGrid extends StatelessWidget {
  final List<_RangeItem> items;
  final String imageUrl;
  const _OurRangeGrid({required this.items, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const spacing = 20.0;
      final maxWidth = constraints.maxWidth;
      int targetPerRow;
      if (maxWidth >= 900) {
        targetPerRow = 4;
      } else if (maxWidth >= 600) {
        targetPerRow = 3;
      } else {
        targetPerRow = 2;
      }
      final totalSpacing = spacing * (targetPerRow - 1);
      final cardWidth = (maxWidth - totalSpacing) / targetPerRow;

      return Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map<Widget>((i) => _RangeCard(
                    title: i.title,
                    route: i.route,
                    imageUrl: imageUrl,
                    maxWidth: cardWidth.clamp(140.0, 220.0),
                  ))
              .toList(),
        ),
      );
    });
  }
}

class _RangeCard extends StatefulWidget {
  final String title;
  final String route;
  final String imageUrl;
  final double maxWidth;
  const _RangeCard({
    required this.title,
    required this.route,
    required this.imageUrl,
    required this.maxWidth,
  });

  @override
  State<_RangeCard> createState() => _RangeCardState();
}

class _RangeCardState extends State<_RangeCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, widget.route),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(widget.imageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey[300])),
                AnimatedContainer(duration: const Duration(milliseconds: 120), color: Colors.black.withOpacity(_hover ? 0.18 : 0.08)),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: Colors.black.withOpacity(0.35),
                    child: Text(widget.title.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonalizeSplit extends StatelessWidget {
  final String imageUrl;
  const _PersonalizeSplit({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 700;
      if (isWide) {
        return Row(
          children: [
            Expanded(child: AspectRatio(aspectRatio: 1.2, child: Image.network(imageUrl, fit: BoxFit.cover))),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Add a personal touch', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  const Text('Personalize your garments and gifts with our in-house printing service.', style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/print-shack'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('LEARN MORE', style: TextStyle(fontSize: 13, letterSpacing: 0.8)),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            AspectRatio(aspectRatio: 1.2, child: Image.network(imageUrl, fit: BoxFit.cover)),
            const SizedBox(height: 24),
            const Text('Add a personal touch', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            const Text('Personalize your garments and gifts with our in-house printing service.', style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/print-shack'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('LEARN MORE', style: TextStyle(fontSize: 13, letterSpacing: 0.8)),
            ),
          ],
        );
      }
    });
  }
}

class _RangeItem {
  final String title;
  final String route;
  const _RangeItem({required this.title, required this.route});
}