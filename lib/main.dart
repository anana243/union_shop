import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/shop_page.dart';
import 'pages/print_shack_page.dart';
import 'pages/sale_page.dart';
import 'pages/about_page.dart';
import 'pages/search_page.dart';
import 'pages/terms_and_conditions_page.dart';
import 'pages/refund_policy_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/product_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_success_page.dart';
import 'pages/clothing_page.dart';
import 'pages/admin_seed_page.dart';
import 'pages/portsmouth_city_page.dart';
import 'pages/pride_page.dart';
import 'pages/graduation_page.dart';
import 'pages/personalization_page.dart';
import 'pages/about_print_shack_page.dart';
import 'pages/merchandise_page.dart';
import 'pages/signature_page.dart';
import 'pages/essential_page.dart';

// Temporary pages
class HungryPage extends StatelessWidget {
  const HungryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hungry')),
      body: const Center(
          child: Text(
              'Temporary Hungry page — replace with external link later.')),
    );
  }
}

class AccommodationPage extends StatelessWidget {
  const AccommodationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accommodation')),
      body: const Center(
          child: Text(
              'Temporary Accommodation page — replace with real route later.')),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/shop': (context) => const ShopPage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/sale': (context) => const SalePage(),
        '/about': (context) => const AboutPage(),
        '/search': (context) => const SearchPage(),
        '/terms-and-conditions': (context) => const TermsAndConditionsPage(),
        '/refund-policy': (context) => const RefundPolicyPage(),
        '/sign-in': (context) => const SignInPage(),
        '/product': (context) => const ProductPage(),
        '/cart': (context) => const CartPage(),
        '/checkout-success': (context) => const CheckoutSuccessPage(),
        '/clothing': (context) => const ClothingPage(),
        '/merchandise': (context) => const MerchandisePage(),
        '/signature': (context) => const SignaturePage(),
        '/essential': (context) => const EssentialPage(),
        '/admin-seed': (context) => const AdminSeedPage(),
        '/portsmouth-city': (context) => const PortsmouthCityPage(),
        '/pride': (context) => const PridePage(),
        '/graduation': (context) => const GraduationPage(),
        '/personalization': (context) => const PersonalizationPage(),
        '/print-shack/about': (context) => const AboutPrintShackPage(),
        '/hungry': (context) => const HungryPage(),
        '/accommodation': (context) => const AccommodationPage(),
      },
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xFF4d2963)),
        useMaterial3: true,
      ),
    );
  }
}
