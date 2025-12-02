import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/shop_page.dart';
import 'pages/print_shack_page.dart';
import 'pages/sale_page.dart';
import 'pages/about_page.dart';
import 'pages/search_page.dart';
import 'pages/terms_and_conditions_page.dart';
import 'pages/refund_policy_page.dart';
import 'product_page.dart';

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
        '/': (context) => const HomePage(),
        '/shop': (context) => const ShopPage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/sale': (context) => const SalePage(),
        '/about': (context) => const AboutPage(),
        '/search': (context) => const SearchPage(),
        '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
        '/refund-policy': (context) => const RefundPolicyPage(),
        '/products': (context) => const Scaffold(
              body: Center(child: Padding(padding: EdgeInsets.all(40), child: Text('All Products Page (coming soon)', style: TextStyle(fontSize: 20)))),
            ),
        '/product': (context) => const ProductPage(),
      },
    );
  }
}
