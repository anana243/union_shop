import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app_layout.dart';

class AdminSeedPage extends StatefulWidget {
  const AdminSeedPage({super.key});

  @override
  State<AdminSeedPage> createState() => _AdminSeedPageState();
}

class _AdminSeedPageState extends State<AdminSeedPage> {
  bool _isLoading = false;
  String _message = '';

  Future<void> _seedCityProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      final cityProducts = [
        {
          'title': 'City Postcard',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 3.50,
          'slug': 'city-postcard',
          'collections': ['city'],
          'featured': false,
        },
        {
          'title': 'City Keyring',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 8.00,
          'slug': 'city-keyring',
          'collections': ['city'],
          'featured': false,
        },
        {
          'title': 'City Badge',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 5.00,
          'slug': 'city-badge',
          'collections': ['city'],
          'featured': false,
        },
      ];

      for (final product in cityProducts) {
        final docRef = db.collection('products').doc(product['slug'] as String);
        batch.set(docRef, product);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'Successfully added 3 Portsmouth City Collection products!';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Admin',
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Admin Seed Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _seedCityProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Add Portsmouth City Products (3 items)'),
              ),
              if (_message.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Error') ? Colors.red : Colors.green,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
