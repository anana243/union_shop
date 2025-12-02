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
        '/products': (context) => const AppLayout(
          title: 'Union',
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Text('All Products Page (coming soon)', style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
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
            child: Center(
              // keep content centered on large screens
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // extra space after hero/header
                      const SizedBox(height: 32),

                      // Essential Range (centered title, responsive layout, smaller tiles)
                      const Center(
                        child: Text(
                          'Essential Range — over 20% off!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth >= 600;
                          // Use Wrap to keep items centered with nice spacing
                          return Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 24,
                            runSpacing: 24,
                            children: [
                              HoverProductTile(
                                title: 'Essential Hoodie',
                                price: '£14.00',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                              HoverProductTile(
                                title: 'Essential Tee',
                                price: '£13.50',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // Signature Range (same style as Essential)
                      const Center(
                        child: Text(
                          'Signature Range',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          HoverProductTile(
                            title: 'Signature Sweatshirt',
                            price: '£22.00',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            onTap: () => Navigator.pushNamed(context, '/product'),
                          ),
                          HoverProductTile(
                            title: 'Signature Cap',
                            price: '£16.00',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            onTap: () => Navigator.pushNamed(context, '/product'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Portsmouth City Collection — two columns on wide, one on phone
                      const Center(
                        child: Text(
                          'Portsmouth City Collection',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final cols = constraints.maxWidth >= 600 ? 2 : 1; // 2x2 like before on wide
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: cols,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            children: [
                              HoverProductTile(
                                title: 'Placeholder Product 1',
                                price: '£10.00',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                              HoverProductTile(
                                title: 'Placeholder Product 2',
                                price: '£15.00',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                              HoverProductTile(
                                title: 'Placeholder Product 3',
                                price: '£20.00',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                              HoverProductTile(
                                title: 'Placeholder Product 4',
                                price: '£25.00',
                                imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                onTap: () => Navigator.pushNamed(context, '/product'),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // View All button centered
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

// Reusable hoverable product tile (adds hover grey, underline on hover, cursor pointer)
class HoverProductTile extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final VoidCallback onTap;

  const HoverProductTile({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<HoverProductTile> createState() => _HoverProductTileState();
}

class _HoverProductTileState extends State<HoverProductTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12), // more breathing room
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onTap, // works on phone as tap
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // avoid expanding beyond grid cell
            children: [
              // Constrain image height to prevent overflow
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 220, // cap image height
                ),
                child: AspectRatio(
                  aspectRatio: 1, // square
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.imageUrl,
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
                      if (_hover)
                        Container(
                          color: Colors.black.withOpacity(0.15),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12), // spacing below image
              Text(
                widget.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  decoration: _hover ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
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
                  // LEFT: Opening hours (unchanged)
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

                  // MIDDLE: Help and Information (unchanged)
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
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/search'),
                            child: HoverText(text: 'Search'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/terms-and-conditions'),
                            child: HoverText(text: 'Terms and Conditions'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/refund-policy'),
                            child: HoverText(text: 'Refund Policy'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // RIGHT: Latest Offers subscribe box (NEW)
                  const Expanded(
                    child: FooterSubscribeBox(),
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

class HoverText extends StatefulWidget {
  final String text;
  
  const HoverText({super.key, required this.text});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Text(
        widget.text,
        style: TextStyle(
          color: isHovering ? Colors.grey[700] : Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}

// Add this widget near the bottom of the file (outside any other class)
class FooterSubscribeBox extends StatefulWidget {
  const FooterSubscribeBox({super.key});

  @override
  State<FooterSubscribeBox> createState() => _FooterSubscribeBoxState();
}

class _FooterSubscribeBoxState extends State<FooterSubscribeBox> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) {
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return re.hasMatch(v);
  }

  void _subscribe() {
    if (!_isValidEmail(_email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subscribed! Check your inbox.')),
    );
    _email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATEST OFFERS',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Color(0xFF4d2963)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _subscribe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'SUBSCRIBE',
                      style: TextStyle(fontSize: 12, letterSpacing: 0.8),
                    ),
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
