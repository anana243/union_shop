// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'widgets/footer_subscribe_box.dart';
import 'widgets/hover_text.dart';

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: const Color(0xFF4d2963),
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _navBtn(context, 'Home', '/'),
                    _navBtn(context, 'Shop', '/shop'),
                    _navBtn(context, 'Print', '/print-shack'),
                    _navBtn(context, 'Sale', '/sale'),
                    _navBtn(context, 'About', '/about'),
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
            child,
            _footer(context),
          ],
        ),
      ),
    );
  }

  TextButton _navBtn(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, route),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(50, 40),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: _FooterHours()),
          Expanded(child: _FooterHelp()),
          const Expanded(child: FooterSubscribeBox()),
        ],
      ),
    );
  }
}

class _FooterHours extends StatelessWidget {
  const _FooterHours();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('OPENING HOURS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text('Winter Break Closure Dates', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text('Closing 4:00 PM 19/12/2025', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Reopening 10:00 AM 05/01/2026', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Last Post Date: 12:00 PM on 18/12/2025', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 12),
        Text('--------------------------------', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 12),
        Text('(Term Time)', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Monday - Friday 10:00 AM - 4:00 PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 12),
        Text('Outside of Term Time / Consolidation Weeks', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 4),
        Text('Monday to Friday 10:00 AM to 3:00 PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 12),
        Text('Purchase Online 24/7', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
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
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => go('/search'),
            child: const HoverText(text: 'Search'),
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => go('/terms-and-conditions'),
            child: const HoverText(text: 'Terms and Conditions'),
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => go('/refund-policy'),
            child: const HoverText(text: 'Refund Policy'),
          ),
        ),
      ],
    );
  }
}