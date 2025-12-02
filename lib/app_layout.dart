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
        toolbarHeight: 72,
        titleSpacing: 0,
        title: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 640;
            if (isNarrow) {
              // Mobile: show brand + menu icon -> opens Drawer
              return Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ],
              );
            }
            // Desktop/tablet: full nav centered and visible
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
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
            );
          },
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
              ExpansionTile(
                title: const Text('Shop'),
                children: const [
                  _DrawerLink('Clothing', '/shop'),
                  _DrawerLink('Merchandise', '/shop'),
                  _DrawerLink('Halloween', '/shop'),
                  _DrawerLink('Signature Range', '/shop'),
                  _DrawerLink('Essential Range', '/shop'),
                  _DrawerLink('Portsmouth City Collection', '/shop'),
                  _DrawerLink('Pride Collection', '/shop'),
                  _DrawerLink('Graduation', '/shop'),
                ],
              ),
              ListTile(
                title: const Text('Print'),
                onTap: () => Navigator.pushReplacementNamed(context, '/print-shack'),
              ),
              ListTile(
                title: const Text('Sale'),
                onTap: () => Navigator.pushReplacementNamed(context, '/sale'),
              ),
              ListTile(
                title: const Text('About'),
                onTap: () => Navigator.pushReplacementNamed(context, '/about'),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // subtle divider below app bar
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;
          final content = [
            const Expanded(child: _FooterHours()),
            const SizedBox(width: 24),
            const Expanded(child: _FooterHelp()),
            const SizedBox(width: 24),
            const Expanded(child: _FooterSubscribeBox()), // ensure subscribe box is present
          ];
          return isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _FooterHours(),
                    SizedBox(height: 24),
                    _FooterHelp(),
                    SizedBox(height: 24),
                    _FooterSubscribeBox(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                );
        },
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final String label;
  final String route;
  const _DrawerLink(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () => Navigator.pushReplacementNamed(context, route),
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
    final isActive = widget.currentRoute == '/shop';
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

class _FooterSubscribeBox extends StatelessWidget {
  const _FooterSubscribeBox();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('LATEST OFFERS & UPDATES', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  isDense: true,
                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Subscribe'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}