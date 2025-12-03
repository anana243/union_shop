// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // left-aligned links
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                runSpacing: 10,
                children: const [
                  Text('Terms & Conditions', style: TextStyle(color: Colors.black54)),
                  Text('•', style: TextStyle(color: Colors.black26)),
                  Text('Refund Policy', style: TextStyle(color: Colors.black54)),
                  Text('•', style: TextStyle(color: Colors.black26)),
                  Text('Opening Times', style: TextStyle(color: Colors.black54)),
                  Text('•', style: TextStyle(color: Colors.black26)),
                  Text('Contact', style: TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 18),
              // subscribe box centered
              const Center(child: FooterSubscribeBox()),
              const SizedBox(height: 10),
              const Center(child: Text('© Union Shop', style: TextStyle(color: Colors.black45))),
            ],
          ),
        ),
      ),
    );
  }
}