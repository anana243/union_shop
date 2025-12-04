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
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 3.50,
          'slug': 'city-postcard',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Illustrated postcard by Julia Gash',
        },
        {
          'title': 'City Keyring',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 8.00,
          'slug': 'city-keyring',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Portsmouth skyline keyring',
        },
        {
          'title': 'City Badge',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 5.00,
          'slug': 'city-badge',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Pin badge from the City Collection',
        },
        {
          'title': 'City Tote',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 10.00,
          'slug': 'city-tote',
          'collections': ['city', 'merchandise'],
          'featured': false,
          'subtitle': 'Canvas tote with city print',
        },
        {
          'title': 'City Notebook',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 7.50,
          'slug': 'city-notebook',
          'collections': ['city', 'merchandise'],
          'featured': true,
          'subtitle': 'A5 notebook with skyline cover',
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

  Future<void> _seedClothingProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      final items = [
        {
          'title': 'Signature Hoodie',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 35.00,
          'slug': 'signature-hoodie',
          'collections': ['clothing', 'signature'],
          'featured': true,
          'subtitle': 'Premium fit with embroidered crest',
        },
        {
          'title': 'Essential T-Shirt',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 12.00,
          'slug': 'essential-tee',
          'collections': ['clothing', 'essential'],
          'featured': true,
          'subtitle': 'Everyday cotton tee',
        },
        {
          'title': 'Varsity Sweatshirt',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 28.00,
          'slug': 'varsity-sweatshirt',
          'collections': ['clothing'],
          'featured': false,
          'subtitle': 'Classic campus style',
        },
        {
          'title': 'Signature Joggers',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 32.00,
          'slug': 'signature-joggers',
          'collections': ['clothing', 'signature'],
          'featured': true,
          'subtitle': 'Comfort joggers with crest',
        },
        {
          'title': 'Essential Hoodie',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 22.00,
          'slug': 'essential-hoodie',
          'collections': ['clothing', 'essential'],
          'featured': false,
          'subtitle': 'Basic hoodie for everyday wear',
        },
        {
          'title': 'Varsity Tee',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 15.00,
          'slug': 'varsity-tee',
          'collections': ['clothing'],
          'featured': false,
          'subtitle': 'Varsity style t-shirt',
        },
      ];

      for (final product in items) {
        final docRef = db.collection('products').doc(product['slug'] as String);
        batch.set(docRef, product);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'Added clothing/signature/essential demo products.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Error: $e';
      });
    }
  }

  Future<void> _seedMerchandiseProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      final items = [
        {
          'title': 'Julia Gash Mug',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 9.00,
          'slug': 'julia-gash-mug',
          'collections': ['merchandise', 'city'],
          'featured': false,
          'subtitle': 'City skyline ceramic mug',
        },
        {
          'title': 'UPSU Tote Bag',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 6.00,
          'slug': 'upsu-tote-bag',
          'collections': ['merchandise', 'upsu'],
          'featured': false,
          'subtitle': 'Reusable cotton tote',
        },
        {
          'title': 'City Magnet',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 4.00,
          'slug': 'city-magnet',
          'collections': ['merchandise', 'city'],
          'featured': true,
          'subtitle': 'Fridge magnet featuring Portsmouth',
        },
        {
          'title': 'UPSU Water Bottle',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 12.00,
          'slug': 'upsu-water-bottle',
          'collections': ['merchandise'],
          'featured': false,
          'subtitle': 'Stainless steel branded bottle',
        },
        {
          'title': 'City Coaster Set',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 6.50,
          'slug': 'city-coasters',
          'collections': ['merchandise', 'city'],
          'featured': true,
          'subtitle': 'Set of 4 skyline coasters',
        },
      ];

      for (final product in items) {
        final docRef = db.collection('products').doc(product['slug'] as String);
        batch.set(docRef, product);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'Added merchandise (Julia Gash/UPSU) demo products.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Error: $e';
      });
    }
  }

  Future<void> _seedSaleProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      final items = [
        {
          'title': 'Clearance Hoodie',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 20.00,
          'slug': 'clearance-hoodie',
          'collections': ['clothing', 'sale'],
          'featured': false,
          'subtitle': 'Last season special',
        },
        {
          'title': 'Sale Mug',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 3.50,
          'slug': 'sale-mug',
          'collections': ['merchandise', 'sale'],
          'featured': false,
          'subtitle': 'Discounted drinkware',
        },
        {
          'title': 'Sale Tee',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'price': 8.00,
          'slug': 'sale-tee',
          'collections': ['clothing', 'sale'],
          'featured': false,
          'subtitle': 'Discount t-shirt',
        },
        {
          'title': 'Sale Tote',
          'imageUrl':
              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 2.50,
          'slug': 'sale-tote',
          'collections': ['merchandise', 'sale'],
          'featured': false,
          'subtitle': 'Clearance tote bag',
        },
      ];

      for (final product in items) {
        final docRef = db.collection('products').doc(product['slug'] as String);
        batch.set(docRef, product);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'Added sale demo products.';
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Add Portsmouth City Products (3 items)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _seedClothingProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text('Add Clothing/Signature/Essential'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _seedMerchandiseProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text('Add Merchandise (Julia Gash/UPSU)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _seedSaleProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text('Add Sale Items'),
              ),
              if (_message.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Error')
                        ? Colors.red
                        : Colors.green,
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
