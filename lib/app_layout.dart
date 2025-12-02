// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const AppLayout({
    super.key,
    required this.child,
    this.title = 'Union',
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4d2963),
        elevation: 0,
        toolbarHeight: 72, // consistent height; avoids overlap
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Left-aligned brand/title
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // Centered nav in available space
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _NavLink(label: 'Home', route: '/', currentRoute: currentRoute),
                    const SizedBox(width: 12),
                    _ShopMenu(currentRoute: currentRoute),
                    const SizedBox(width: 12),
                    _NavLink(label: 'Print', route: '/print-shack', currentRoute: currentRoute),
                    const SizedBox(width: 12),
                    _NavLink(label: 'Sale', route: '/sale', currentRoute: currentRoute),
                    const SizedBox(width: 12),
                    _NavLink(label: 'About', route: '/about', currentRoute: currentRoute),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // A small divider to visually separate when needed
            Container(height: 1, color: Colors.black.withOpacity(0.05)),
            child,
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _FooterHours()),
          Expanded(child: _FooterHelp()),
          Expanded(child: SizedBox()), // placeholder third column if you don’t have subscribe box
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final String route;
  final String currentRoute;
  const _NavLink({
    required this.label,
    required this.route,
    required this.currentRoute,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.currentRoute == widget.route;
    final underline = _hover || isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {
          if (widget.currentRoute != widget.route) {
            Navigator.pushReplacementNamed(context, widget.route);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              letterSpacing: 0.3,
              decoration: underline ? TextDecoration.underline : TextDecoration.none,
              decorationColor: Colors.white,
              decorationThickness: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopMenu extends StatefulWidget {
  final String currentRoute;
  const _ShopMenu({required this.currentRoute});

  @override
  State<_ShopMenu> createState() => _ShopMenuState();
}

class _ShopMenuState extends State<_ShopMenu> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.currentRoute == '/shop'; // underline shop when on /shop
    final underline = _hover || isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: PopupMenuButton<_ShopItem>(
        offset: const Offset(0, 12),
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onSelected: (item) => Navigator.pushReplacementNamed(context, item.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Shop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.3,
                  decoration: underline ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                  decorationThickness: 2,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
            ],
          ),
        ),
        itemBuilder: (context) => [
          _menuItem('Clothing', '/shop'),
          _menuItem('Merchandise', '/shop'),
          _menuItem('Halloween', '/shop'),
          _menuItem('Signature Range', '/shop'),
          _menuItem('Essential Range', '/shop'),
          _menuItem('Portsmouth City Collection', '/shop'),
          _menuItem('Pride Collection', '/shop'),
          _menuItem('Graduation', '/shop'),
        ],
      ),
    );
  }

  PopupMenuItem<_ShopItem> _menuItem(String label, String route) {
    return PopupMenuItem<_ShopItem>(
      value: _ShopItem(label: label, route: route),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _ShopItem {
  final String label;
  final String route;
  const _ShopItem({required this.label, required this.route});
}

class _FooterHours extends StatelessWidget {
  const _FooterHours();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OPENING HOURS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text('Winter Break Closure Dates', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text('Closing 4:00 PM 19/12/2025', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Reopening 10:00 AM 05/01/2026', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Last Post Date: 12:00 PM on 18/12/2025', style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _FooterHelp extends StatelessWidget {
  const _FooterHelp();

  @override
  Widget build(BuildContext context) {
    void go(String route) => Navigator.pushReplacementNamed(context, route);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('HELP AND INFORMATION', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GestureDetector(onTap: () => go('/search'), child: const Text('Search')),
        const SizedBox(height: 8),
        GestureDetector(onTap: () => go('/terms-and-conditions'), child: const Text('Terms and Conditions')),
        const SizedBox(height: 8),
        GestureDetector(onTap: () => go('/refund-policy'), child: const Text('Refund Policy')),
      ],
    );
  }
}