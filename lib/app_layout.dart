// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/footer_subscribe_box.dart';
import 'services/cart_service.dart';

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
        automaticallyImplyLeading: isMobile,
        title: isMobile
            ? Text(widget.title)
            : Row(
                children: [
                  Text(widget.title),
                  const SizedBox(width: 32),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                      child: const Text('HOME',
                          style: TextStyle(color: Colors.white))),
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        Navigator.pushReplacementNamed(context, value),
                    offset: const Offset(0, 40),
                    child: TextButton(
                      onPressed: null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('SHOP', style: TextStyle(color: Colors.white)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: '/clothing', child: Text('Clothing')),
                      const PopupMenuItem(
                          value: '/shop', child: Text('Merchandise')),
                      const PopupMenuItem(
                          value: '/shop', child: Text('Signature Range')),
                      const PopupMenuItem(
                          value: '/shop', child: Text('Essential Range')),
                      const PopupMenuItem(
                          value: '/portsmouth-city',
                          child: Text('Portsmouth City Collection')),
                      const PopupMenuItem(
                          value: '/pride', child: Text('Pride Collection')),
                      const PopupMenuItem(
                          value: '/graduation', child: Text('Graduation')),
                    ],
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        Navigator.pushReplacementNamed(context, value),
                    offset: const Offset(0, 40),
                    child: TextButton(
                      onPressed: null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('PRINT SHACK',
                              style: TextStyle(color: Colors.white)),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: '/print-shack/about',
                          child: Text('About Print Shack')),
                      const PopupMenuItem(
                          value: '/personalization',
                          child: Text('Personalization')),
                    ],
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/sale'),
                      child: const Text('SALE',
                          style: TextStyle(color: Colors.white))),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/about'),
                      child: const Text('ABOUT',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
        bottom: _searchOpen && isMobile
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Container(
                  color: const Color(0xFF4d2963),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onSubmitted: (query) {
                      Navigator.pushNamed(context, '/search', arguments: query);
                      setState(() => _searchOpen = false);
                    },
                  ),
                ),
              )
            : null,
        actions: [
          if (_searchOpen && !isMobile)
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none),
                onSubmitted: (query) {
                  Navigator.pushNamed(context, '/search', arguments: query);
                  setState(() => _searchOpen = false);
                },
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
          // Cart icon with badge
          AnimatedBuilder(
            animation: CartService.instance,
            builder: (context, _) {
              final count = CartService.instance.count;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    tooltip: 'Cart',
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('$count',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                      ),
                    ),
                ],
              );
            },
          ),
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (user != null) {
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.person),
                  tooltip: 'Account',
                  offset: const Offset(0, 50),
                  onSelected: (value) async {
                    if (value == 'signout') {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Signed out successfully')),
                        );
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      enabled: false,
                      child: Text(
                        user.email ?? 'User',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<String>(
                      value: 'signout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 18),
                          SizedBox(width: 8),
                          Text('Sign Out'),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return IconButton(
                icon: const Icon(Icons.person_outline),
                tooltip: 'Sign In',
                onPressed: () => Navigator.pushNamed(context, '/sign-in'),
              );
            },
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
                      child: Text('Menu',
                          style: TextStyle(color: Colors.white, fontSize: 24))),
                  ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/')),
                  ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: const Text('Shop'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/shop')),
                  ListTile(
                      leading: const Icon(Icons.palette),
                      title: const Text('Print Shack'),
                      onTap: () => Navigator.pushReplacementNamed(
                          context, '/print-shack')),
                  ListTile(
                      leading: const Icon(Icons.local_offer),
                      title: const Text('Sale'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/sale')),
                  ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/about')),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.child,
            const _Footer(),
          ],
        ),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FooterLinksRow(),
                    const SizedBox(height: 18),
                    Center(child: FooterSubscribeBox()),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _FooterLinksRow()),
                    const SizedBox(width: 20),
                    SizedBox(width: 360, child: FooterSubscribeBox()),
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

class _FooterLinksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle link = const TextStyle(
        color: Colors.black54, decoration: TextDecoration.underline);
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.schedule, size: 18, color: Colors.black38),
            SizedBox(width: 6),
            SizedBox(
              width: 260,
              child: Text('Opening Times: Mon–Fri 9:00–17:00',
                  style: TextStyle(color: Colors.black54),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Text('Terms & Conditions', style: link),
        Text('Refund Policy', style: link),
        Text('Contact', style: link),
      ],
    );
  }
}
