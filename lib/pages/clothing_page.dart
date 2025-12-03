import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';

class ClothingPage extends StatefulWidget {
  const ClothingPage({super.key});

  @override
  State<ClothingPage> createState() => _ClothingPageState();
}

class _ClothingPageState extends State<ClothingPage> {
  String _filterBy = 'All Products';
  String _sortBy = 'Featured';

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 200,
        ),
        padding: const EdgeInsets.all(40.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Clothing',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Text('Filter by:', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _filterBy,
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(
                            value: 'All Products', child: Text('All Products')),
                        DropdownMenuItem(
                            value: 'Clothing', child: Text('Clothing')),
                        DropdownMenuItem(
                            value: 'Merchandise', child: Text('Merchandise')),
                        DropdownMenuItem(
                            value: 'Popular', child: Text('Popular')),
                        DropdownMenuItem(value: 'UPSU', child: Text('UPSU')),
                      ],
                      onChanged: (value) => setState(() => _filterBy = value!),
                    ),
                    const SizedBox(width: 24),
                    const Text('Sort by:', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _sortBy,
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(
                            value: 'Featured', child: Text('Featured')),
                        DropdownMenuItem(
                            value: 'Best Selling', child: Text('Best Selling')),
                        DropdownMenuItem(
                            value: 'A-Z', child: Text('Alphabetically, A-Z')),
                        DropdownMenuItem(
                            value: 'Z-A', child: Text('Alphabetically, Z-A')),
                        DropdownMenuItem(
                            value: 'Price Low',
                            child: Text('Price, Low to High')),
                        DropdownMenuItem(
                            value: 'Price High',
                            child: Text('Price, High to Low')),
                        DropdownMenuItem(
                            value: 'Date Old', child: Text('Date, Old to New')),
                        DropdownMenuItem(
                            value: 'Date New', child: Text('Date, New to Old')),
                      ],
                      onChanged: (value) => setState(() => _sortBy = value!),
                    ),
                    const Spacer(),
                    const Text('0 products', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FutureBuilder<List<Product>>(
                future: ProductRepository().listByCollection('clothing'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('No products available yet',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    );
                  }

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 24,
                    runSpacing: 24,
                    children: products
                        .map((p) => ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 220),
                              child: ProductTile(product: p),
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
