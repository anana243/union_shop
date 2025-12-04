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

  Future<void> _clearAllProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final snapshot = await db.collection('products').get();
      final batch = db.batch();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'All products cleared! Now seed fresh data.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Error clearing: $e';
      });
    }
  }

  Future<void> _seedAllProducts() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      final allProducts = [
        // City Collection (pure city)
        {
          'title': 'City Postcard',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/city-postcard.jpg',
          'price': 3.50,
          'slug': 'city-postcard',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Illustrated postcard by Julia Gash',
        },
        {
          'title': 'City Keyring',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 8.00,
          'slug': 'city-keyring',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Portsmouth skyline keyring',
        },
        {
          'title': 'City Badge',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/city-badge.jpg',
          'price': 5.00,
          'slug': 'city-badge',
          'collections': ['city'],
          'featured': false,
          'subtitle': 'Pin badge from the City Collection',
        },
        {
          'title': 'City Notebook',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'price': 7.50,
          'slug': 'city-notebook',
          'collections': ['city'],
          'featured': true,
          'subtitle': 'A5 notebook with skyline cover',
        },
        // Clothing Collection (pure clothing)
        {
          'title': 'Varsity Sweatshirt',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/varsity-sweatshirt.jpg',
          'price': 28.00,
          'slug': 'varsity-sweatshirt',
          'collections': ['clothing'],
          'featured': false,
          'subtitle': 'Classic campus style',
        },
        {
          'title': 'Varsity Tee',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/varsity-tee.jpg',
          'price': 15.00,
          'slug': 'varsity-tee',
          'collections': ['clothing'],
          'featured': false,
          'subtitle': 'Varsity style t-shirt',
        },
        // Signature Range (clothing + signature)
        {
          'title': 'Signature Hoodie',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/signature-hoodie.jpg',
          'price': 35.00,
          'slug': 'signature-hoodie',
          'collections': ['clothing', 'signature'],
          'featured': true,
          'subtitle': 'Premium fit with embroidered crest',
        },
        {
          'title': 'Signature Joggers',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/signature-joggers.jpg',
          'price': 32.00,
          'slug': 'signature-joggers',
          'collections': ['clothing', 'signature'],
          'featured': true,
          'subtitle': 'Comfort joggers with crest',
        },
        {
          'title': 'Signature Cap',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/signature-cap.jpg',
          'price': 18.00,
          'slug': 'signature-cap',
          'collections': ['clothing', 'signature'],
          'featured': false,
          'subtitle': 'Signature collection cap',
        },
        // Essential Range (clothing + essential)
        {
          'title': 'Essential T-Shirt',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/essential-tee.jpg',
          'price': 12.00,
          'slug': 'essential-tee',
          'collections': ['clothing', 'essential'],
          'featured': true,
          'subtitle': 'Everyday cotton tee',
        },
        {
          'title': 'Essential Hoodie',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/essential-hoodie.png',
          'price': 22.00,
          'slug': 'essential-hoodie',
          'collections': ['clothing', 'essential'],
          'featured': false,
          'subtitle': 'Basic hoodie for everyday wear',
        },
        {
          'title': 'Essential Sweatshirt',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/essential-sweatshirt.jpg',
          'price': 20.00,
          'slug': 'essential-sweatshirt',
          'collections': ['clothing', 'essential'],
          'featured': false,
          'subtitle': 'Essential range sweatshirt',
        },
        // Merchandise - City themed (merchandise + city)
        {
          'title': 'City Magnet',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/city-magnet.jpg',
          'price': 4.00,
          'slug': 'city-magnet',
          'collections': ['merchandise', 'city'],
          'featured': true,
          'subtitle': 'Fridge magnet featuring Portsmouth',
        },
        {
          'title': 'Julia Gash Mug',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/julia-gash-mug.jpg',
          'price': 9.00,
          'slug': 'julia-gash-mug',
          'collections': ['merchandise', 'city'],
          'featured': false,
          'subtitle': 'City skyline ceramic mug',
        },
        {
          'title': 'City Coaster Set',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/city-coaster-set.jpg',
          'price': 6.50,
          'slug': 'city-coasters',
          'collections': ['merchandise', 'city'],
          'featured': true,
          'subtitle': 'Set of 4 skyline coasters',
        },
        // Merchandise - General (merchandise only)
        {
          'title': 'UPSU Water Bottle',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/upsu-water-bottle.jpg',
          'price': 12.00,
          'slug': 'upsu-water-bottle',
          'collections': ['merchandise'],
          'featured': false,
          'subtitle': 'Stainless steel branded bottle',
        },
        {
          'title': 'UPSU Tote Bag',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/upsu-tote-bag.jpg',
          'price': 6.00,
          'slug': 'upsu-tote-bag',
          'collections': ['merchandise'],
          'featured': false,
          'subtitle': 'Reusable cotton tote',
        },
        {
          'title': 'City Tote',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/city-tote.jpg',
          'price': 10.00,
          'slug': 'city-tote',
          'collections': ['merchandise'],
          'featured': false,
          'subtitle': 'Canvas tote with city print',
        },
        // Sale items (clothing + sale, merchandise + sale)
        {
          'title': 'Clearance Hoodie',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/clearance-hoodie.jpg',
          'price': 20.00,
          'slug': 'clearance-hoodie',
          'collections': ['clothing', 'sale'],
          'featured': false,
          'subtitle': 'Last season special',
        },
        {
          'title': 'Sale Tee',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/sale-tee.jpg',
          'price': 8.00,
          'slug': 'sale-tee',
          'collections': ['clothing', 'sale'],
          'featured': false,
          'subtitle': 'Discount t-shirt',
        },
        {
          'title': 'Sale Mug',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/sale-mug.jpg',
          'price': 3.50,
          'slug': 'sale-mug',
          'collections': ['merchandise', 'sale'],
          'featured': false,
          'subtitle': 'Discounted drinkware',
        },
        {
          'title': 'Sale Tote',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/sale-tote.jpg',
          'price': 2.50,
          'slug': 'sale-tote',
          'collections': ['merchandise', 'sale'],
          'featured': false,
          'subtitle': 'Clearance tote bag',
        },
        // Graduation Collection (clothing + graduation)
        {
          'title': 'Graduation Hoodie',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/graduation-hoodie.jpg',
          'price': 40.00,
          'slug': 'graduation-hoodie',
          'collections': ['clothing', 'graduation'],
          'featured': true,
          'subtitle': 'Special graduation edition',
        },
        {
          'title': 'Graduation Tee',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/graduation-tee.jpg',
          'price': 16.00,
          'slug': 'graduation-tee',
          'collections': ['clothing', 'graduation'],
          'featured': false,
          'subtitle': 'Graduation class tee',
        },
        {
          'title': 'Graduation Cap',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/graduation-cap.jpg',
          'price': 25.00,
          'slug': 'graduation-cap',
          'collections': ['merchandise', 'graduation'],
          'featured': false,
          'subtitle': 'Graduation collection cap',
        },
        // Pride Collection (clothing + pride, merchandise + pride)
        {
          'title': 'Pride Hoodie',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/pride-hoodie.jpg',
          'price': 30.00,
          'slug': 'pride-hoodie',
          'collections': ['clothing', 'pride'],
          'featured': true,
          'subtitle': 'Celebrate Pride Month',
        },
        {
          'title': 'Pride Tee',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
          'imageAsset': 'assets/images/products/pride-tee.jpg',
          'price': 14.00,
          'slug': 'pride-tee',
          'collections': ['clothing', 'pride'],
          'featured': false,
          'subtitle': 'Pride collection t-shirt',
        },
        {
          'title': 'Pride Badge',
          'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
          'imageAsset': 'assets/images/products/pride-badge.jpg',
          'price': 4.50,
          'slug': 'pride-badge',
          'collections': ['merchandise', 'pride'],
          'featured': true,
          'subtitle': 'Pride collection badge',
        },
      ];

      for (final product in allProducts) {
        final docRef = db.collection('products').doc(product['slug'] as String);
        batch.set(docRef, product);
      }

      await batch.commit();

      setState(() {
        _isLoading = false;
        _message = 'Successfully seeded ${allProducts.length} products with proper collections!';
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
                onPressed: _isLoading ? null : _clearAllProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text('CLEAR ALL PRODUCTS'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _seedAllProducts,
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
                    : const Text('SEED ALL PRODUCTS (Fresh Data)'),
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 32),
              if (_message.isNotEmpty) ...[
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
