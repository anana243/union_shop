import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show ScrollNotification, ScrollUpdateNotification, ScrollEndNotification;
import '../app_layout.dart';
import '../widgets/product_tile.dart';
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
          const _HeroCarousel(imageUrl: _heroImageUrl),
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

                _buildProductGroup('Essential Range — over 20% off!', essential),
                const SizedBox(height: 40),

                _buildProductGroup('Signature Range', signature),
                const SizedBox(height: 40),

                _buildProductGroup('Portsmouth City Collection', city),

                const SizedBox(height: 24),
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

                const SizedBox(height: 40),
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

                const SizedBox(height: 64), // extra spacing between sections

                _PersonalizeSplit(imageUrl: _productImageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGroup(String title, List<Product> products) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 32,
          children: products.map((p) => ProductTile(product: p)).toList(),
        ),
      ],
    );
  }
}

class _HeroCarousel extends StatefulWidget {
  final String imageUrl;
  const _HeroCarousel({required this.imageUrl});

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  final PageController _controller = PageController();
  int _index = 0;
  bool _paused = false;
  Timer? _autoTimer;
  Timer? _idleResumeTimer; // debounce resume after user scroll

  final List<_SlideData> _slides = [];

  @override
  void initState() {
    super.initState();
    _slides.addAll([
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'Essential Range — over 20% off!',
        body: 'Over 20% off our Essential Range. Come and grab yours while stock lasts.',
        ctaLabel: 'BROWSE COLLECTION',
        onTapRoute: '/shop',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'The Print Shack',
        body: 'Let’s create something uniquely you with our personalization service — from £3 for one line of text.',
        ctaLabel: 'FIND OUT MORE',
        onTapRoute: '/print-shack',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'Hungry?',
        body: 'We got this 🍕',
        ctaLabel: 'ORDER DOMINO’S PIZZA NOW',
        onTapRoute: '/hungry',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'What’s your next move…',
        body: 'Are you with us?',
        ctaLabel: 'FIND YOUR STUDENT ACCOMMODATION',
        onTapRoute: '/accommodation',
      ),
    ]);

    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _index) {
        setState(() => _index = newIndex);
      }
    });

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_paused && mounted) _next();
    });
  }

  void _togglePause() {
    setState(() => _paused = !_paused);
    if (!_paused) _restartAutoAfterIdle(); // resume autoplay
  }

  void _pauseForUser() {
    if (_paused) return;
    setState(() => _paused = true);
    _idleResumeTimer?.cancel();
  }

  void _restartAutoAfterIdle() {
    _idleResumeTimer?.cancel();
    _idleResumeTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) setState(() => _paused = false);
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _idleResumeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    _pauseForUser();
    final target = (_index - 1).clamp(0, _slides.length - 1);
    _controller.animateToPage(target, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  void _next() {
    _pauseForUser();
    final target = (_index + 1) % _slides.length;
    _controller.animateToPage(target, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  void _jumpTo(int i) {
    _pauseForUser();
    _controller.animateToPage(i, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isPhone = w < 600;
    final height = isPhone ? 300.0 : 340.0; // smaller than before

    return SizedBox(
      height: height,
      width: double.infinity,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _pauseForUser();
          } else if (notification is ScrollEndNotification) {
            _restartAutoAfterIdle();
          }
          return false;
        },
        child: Stack(
          children: [
            // Full-bleed hero image with overlay
            PageView.builder(
              controller: _controller,
              itemCount: _slides.length,
              itemBuilder: (context, i) => _HeroSlide(data: _slides[i]),
            ),

            // Minimal control cluster centered near bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Left arrow close to dots
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _prev,
                        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                        tooltip: 'Previous',
                      ),
                      const SizedBox(width: 6),

                      // Dots (clickable)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_slides.length, (i) {
                          final active = i == _index;
                          return GestureDetector(
                            onTap: () => _jumpTo(i),
                            child: Container(
                              width: active ? 10 : 8,
                              height: active ? 10 : 8,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: active ? Colors.white : Colors.white.withOpacity(0.6),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(width: 6),
                      // Right arrow close to dots
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _next,
                        icon: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                        tooltip: 'Next',
                      ),

                      const SizedBox(width: 8),
                      // Pause/play close to dots
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _togglePause,
                        icon: Icon(_paused ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 20),
                        tooltip: _paused ? 'Resume' : 'Pause',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Keep _HeroSlide full-width and revert any extra clipping/padding previously added
class _HeroSlide extends StatelessWidget {
  final _SlideData data;
  const _HeroSlide({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.imageUrl),
                fit: BoxFit.cover, // full-width image
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.65)),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          top: 60, // slightly higher to keep controls unobstructed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                data.body,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, data.onTapRoute),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child: Text(data.ctaLabel, style: const TextStyle(fontSize: 13, letterSpacing: 0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RangeItem {
  final String title;
  final String route;
  const _RangeItem({required this.title, required this.route});
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
                    maxWidth: cardWidth.clamp(140.0, 240.0),
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
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  color: Colors.black.withOpacity(_hover ? 0.18 : 0.08),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: Colors.black.withOpacity(0.35),
                    child: Text(
                      widget.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
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
      final isWide = constraints.maxWidth >= 800;

      final textBlock = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add a personal touch', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text(
            'First, add your item of clothing to your cart, then click below to add your text!\n'
            'One line of text contains 10 characters!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/print-shack'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.symmetric(horizontal: 18),
              ),
              child: const Text('CLICK HERE TO ADD TEXT', style: TextStyle(fontSize: 13, letterSpacing: 0.8)),
            ),
          ),
        ],
      );

      final imageBlock = AspectRatio(
        aspectRatio: isWide ? 1.6 : 1.2,
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: Colors.grey[300]),
          ),
        ),
      );

      if (isWide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: textBlock),
            const SizedBox(width: 24),
            Expanded(child: imageBlock),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageBlock,
            const SizedBox(height: 20),
            textBlock,
          ],
        );
      }
    });
  }
}