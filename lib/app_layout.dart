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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4d2963),
        foregroundColor: Colors.white,
        title: Text(widget.title),
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
                    hintText: 'Search...',
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
            onPressed: () {
              setState(() {
                _searchOpen = !_searchOpen;
                if (!_searchOpen) _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/sign-in'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF4d2963)),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(title: const Text('Home'), onTap: () => Navigator.pushReplacementNamed(context, '/')),
            ListTile(title: const Text('Shop'), onTap: () => Navigator.pushReplacementNamed(context, '/shop')),
            ListTile(title: const Text('Print Shack'), onTap: () => Navigator.pushReplacementNamed(context, '/print-shack')),
            ListTile(title: const Text('Sale'), onTap: () => Navigator.pushReplacementNamed(context, '/sale')),
            ListTile(title: const Text('About'), onTap: () => Navigator.pushReplacementNamed(context, '/about')),
          ],
        ),
      ),
      body: SingleChildScrollView(child: widget.child),
    );
  }
}