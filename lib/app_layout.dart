// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'widgets/footer_subscribe_box.dart';

class AppLayout extends StatefulWidget {
  final String title;
  final Widget child;

  const AppLayout({super.key, required this.title, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool _searchOpen = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4d2963),
        foregroundColor: Colors.white,
        // Remove redundant desktop Home icon
        leading: MediaQuery.of(context).size.width < 900 ? null : null,
        title: isMobile
            ? Text(widget.title)
            : Row(
                children: [
                  Text(widget.title),
                  const SizedBox(width: 32),
                  if (!_searchOpen) ...[
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                      child: const Text('HOME', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/shop'),
                      child: const Text('SHOP', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/print-shack'),
                      child: const Text('PRINT SHACK', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/sale'),
                      child: const Text('SALE', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/about'),
                      child: const Text('ABOUT', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ],
              ),
        actions: [
          if (_searchOpen)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (query) {
                    Navigator.pushNamed(context, '/search', arguments: query);
                    setState(() => _searchOpen = false);
                  },
                ),
              ),
            ),
          IconButton(
            icon: Icon(_searchOpen ? Icons.close : Icons.search),
            tooltip: 'Search',
            onPressed: () {
              setState(() {
                _searchOpen = !_searchOpen;
                if (!_searchOpen) _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'Cart',
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Account',
            onPressed: () => Navigator.pushNamed(context, '/sign-in'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF4d2963)),
                    child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () => Navigator.pushReplacementNamed(context, '/')),
                  ListTile(leading: const Icon(Icons.shopping_bag), title: const Text('Shop'), onTap: () => Navigator.pushReplacementNamed(context, '/shop')),
                  ListTile(leading: const Icon(Icons.print), title: const Text('Print Shack'), onTap: () => Navigator.pushReplacementNamed(context, '/print-shack')),
                  ListTile(leading: const Icon(Icons.local_offer), title: const Text('Sale'), onTap: () => Navigator.pushReplacementNamed(context, '/sale')),
                  ListTile(leading: const Icon(Icons.info), title: const Text('About'), onTap: () => Navigator.pushReplacementNamed(context, '/about')),
                ],
              ),
            )
          : null,
      // Restore footer
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: widget.child)),
          const _Footer(),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 700;
              if (isNarrow) {
                // Stack vertically on narrow screens
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FooterLinksRow(),
                    const SizedBox(height: 18),
                    Center(child: FooterSubscribeBox()),
                    const SizedBox(height: 10),
                    const Center(child: Text('© Union Shop', style: TextStyle(color: Colors.black45))),
                  ],
                );
              } else {
                // Left links, right subscribe box (classic layout)
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _FooterLinksRow()),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 360, // subscribe panel width
                          child: FooterSubscribeBox(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('© Union Shop', style: TextStyle(color: Colors.black45)),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// Footer links: Opening Times detail, Terms, Refund, Contact
class _FooterLinksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle link = const TextStyle(color: Colors.black54, decoration: TextDecoration.underline);
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children: [
        // Opening Times – inline details bubble style preserved by simple text
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.schedule, size: 18, color: Colors.black38),
            SizedBox(width: 6),
            Text('Opening Times: Mon–Fri 9:00–17:00', style: TextStyle(color: Colors.black54)),
          ],
        ),
        // Terms & Conditions
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/terms-and-conditions'),
          child: Text('Terms & Conditions', style: link),
        ),
        // Refund Policy
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/refund-policy'),
          child: Text('Refund Policy', style: link),
        ),
        // Contact (kept as simple text; replace with route when you have it)
        GestureDetector(
          onTap: () {
            // TODO: add contact route or external link when ready
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contact page coming soon')),
            );
          },
          child: Text('Contact', style: link),
        ),
      ],
    );
  }
}