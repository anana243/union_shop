import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../widgets/product_tile.dart';
import '../widgets/hero_carousel.dart';
import '../constants.dart';
import '../models/product.dart';
import '../services/product_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _heroImageUrl = kHeroImageUrl;

  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository();

    return AppLayout(
      title: 'Union',
      child: Column(
        children: [
          HeroCarousel(imageUrl: _heroImageUrl),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  _Section(
                    title: 'Essential Range - over 20% off!',
                    future: repo.listByCollection('essential'),
                  ),
                  const SizedBox(height: 40),
                  _Section(
                    title: 'Signature Range',
                    future: repo.listByCollection('signature'),
                  ),
                  const SizedBox(height: 40),
                  _Section(
                    title: 'Portsmouth City Collection',
                    future: repo.listByCollection('city'),
                    cityLayout: true,
                  ),
                  const SizedBox(height: 32),
                  const Center(
                    child: Text('Our Range',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 20),
                  _OurRangeGrid(
                    items: const [
                      _RangeItem(title: 'Clothing', route: '/shop'),
                      _RangeItem(title: 'Merchandise', route: '/shop'),
                      _RangeItem(title: 'Graduation', route: '/shop'),
                      _RangeItem(title: 'Sale', route: '/sale'),
                    ],
                    imageUrl:
                        _heroImageUrl, // use the same hero image to avoid duplication
                  ),
                  const SizedBox(height: 64),
                  _PersonalizeSplit(
                    imageUrl: _heroImageUrl, // reuse constant
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

class _Section extends StatelessWidget {
  final String title;
  final Future<List<Product>> future;
  final bool cityLayout;

  const _Section({
    required this.title,
    required this.future,
    this.cityLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600)),
              ),
            ),
            if (cityLayout)
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/portsmouth-city'),
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<Product>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final products = snapshot.data ?? [];
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            if (cityLayout) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, i) => ProductTile(product: products[i]),
              );
            }

            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: products
                  .map((p) => ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 220),
                        child: ProductTile(product: p),
                      ))
                  .toList(),
            );
          },
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
        onTap: () => Navigator.pushNamed(context, widget.route),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        Container(color: Colors.grey[300])),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    color: Colors.black.withOpacity(_hover ? 0.18 : 0.08)),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: Colors.black.withOpacity(0.35),
                    child: Text(widget.title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8)),
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
            Expanded(
                child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(imageUrl, fit: BoxFit.cover))),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Add a personal touch',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  const Text(
                      'Personalize your garments and gifts with our in-house printing service.',
                      style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/print-shack'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text('LEARN MORE',
                        style: TextStyle(fontSize: 13, letterSpacing: 0.8)),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(imageUrl, fit: BoxFit.cover)),
            const SizedBox(height: 24),
            const Text('Add a personal touch',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            const Text(
                'Personalize your garments and gifts with our in-house printing service.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/print-shack'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('LEARN MORE',
                  style: TextStyle(fontSize: 13, letterSpacing: 0.8)),
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
