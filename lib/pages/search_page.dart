import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final query = ModalRoute.of(context)?.settings.arguments as String?;

    if (query == null || query.trim().isEmpty) {
      return AppLayout(
        title: 'Union',
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 200,
          ),
          padding: const EdgeInsets.all(40.0),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Enter a search term',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 200,
        ),
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Search Results for "$query"',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FutureBuilder<List<Product>>(
                  future: ProductRepository().searchProducts(query),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              const SizedBox(height: 16),
                              Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final products = snapshot.data ?? [];

                    if (products.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              const Icon(Icons.search_off,
                                  size: 64, color: Colors.grey),
                              const SizedBox(height: 16),
                              Text(
                                'No products found for "$query"',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Try different keywords or browse our collections',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            '${products.length} result${products.length == 1 ? '' : 's'} found',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        ProductGrid(products: products),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
