import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class ClothingPage extends StatefulWidget {
  const ClothingPage({super.key});

  @override
  State<ClothingPage> createState() => _ClothingPageState();
}

class _ClothingPageState extends State<ClothingPage> {
  String _filterBy = 'All Products';
  String _sortBy = 'Featured';
  int _currentPage = 1;
  final int _itemsPerPage = 12;

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
                    FutureBuilder<List<Product>>(
                      future: ProductRepository().listByCollection('clothing'),
                      builder: (context, snapshot) {
                        final count = snapshot.data?.length ?? 0;
                        return Text('$count products',
                            style: const TextStyle(fontSize: 14));
                      },
                    ),
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

                  final allProducts = List<Product>.from(snapshot.data ?? []);
                  if (allProducts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('No products available yet',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    );
                  }

                  // Basic client-side sorting
                  switch (_sortBy) {
                    case 'A-Z':
                      allProducts.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
                      break;
                    case 'Z-A':
                      allProducts.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
                      break;
                    case 'Price Low':
                      allProducts.sort((a, b) => a.price.compareTo(b.price));
                      break;
                    case 'Price High':
                      allProducts.sort((a, b) => b.price.compareTo(a.price));
                      break;
                    // Featured/Best Selling/Date sorts are placeholders without data fields
                    default:
                      break;
                  }

                    final totalPages =
                      (allProducts.length / _itemsPerPage).ceil();
                  final startIndex = (_currentPage - 1) * _itemsPerPage;
                  final endIndex =
                      (startIndex + _itemsPerPage).clamp(0, allProducts.length);
                  final products = allProducts.sublist(startIndex, endIndex);

                  return Column(
                    children: [
                      ProductGrid(products: products),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: _currentPage > 1
                                ? () => setState(() => _currentPage--)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Page $_currentPage of $totalPages',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: _currentPage < totalPages
                                ? () => setState(() => _currentPage++)
                                : null,
                          ),
                        ],
                      ),
                    ],
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
