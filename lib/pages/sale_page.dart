import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _sortBy = 'Featured';
  late final ProductRepository _repo;
  Future<List<Product>>? _future;

  @override
  void initState() {
    super.initState();
    _repo = ProductRepository();
    _future = _repo.listByCollection('sale');
  }

  void _sort(List<Product> items) {
    switch (_sortBy) {
      case 'A-Z':
        items.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Z-A':
        items.sort(
            (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
      case 'Price Low':
        items.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price High':
        items.sort((a, b) => b.price.compareTo(a.price));
        break;
      default:
        break;
    }
  }

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
                'Sale',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 16,
                      vertical: isMobile ? 8 : 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text('Sort:',
                              style: TextStyle(fontSize: isMobile ? 11 : 14)),
                          SizedBox(width: isMobile ? 4 : 8),
                          DropdownButton<String>(
                            value: _sortBy,
                            underline: Container(),
                            isDense: true,
                            style: TextStyle(
                                fontSize: isMobile ? 11 : 14,
                                color: Colors.black),
                            items: [
                              DropdownMenuItem(
                                  value: 'Featured',
                                  child: Text('Featured',
                                      style: TextStyle(
                                          fontSize: isMobile ? 11 : 14))),
                              DropdownMenuItem(
                                  value: 'A-Z',
                                  child: Text(
                                      isMobile ? 'A-Z' : 'Alphabetically, A-Z',
                                      style: TextStyle(
                                          fontSize: isMobile ? 11 : 14))),
                              DropdownMenuItem(
                                  value: 'Z-A',
                                  child: Text(
                                      isMobile ? 'Z-A' : 'Alphabetically, Z-A',
                                      style: TextStyle(
                                          fontSize: isMobile ? 11 : 14))),
                              DropdownMenuItem(
                                  value: 'Price Low',
                                  child: Text(
                                      isMobile
                                          ? 'Price ↑'
                                          : 'Price, Low to High',
                                      style: TextStyle(
                                          fontSize: isMobile ? 11 : 14))),
                              DropdownMenuItem(
                                  value: 'Price High',
                                  child: Text(
                                      isMobile
                                          ? 'Price ↓'
                                          : 'Price, High to Low',
                                      style: TextStyle(
                                          fontSize: isMobile ? 11 : 14))),
                            ],
                            onChanged: (value) =>
                                setState(() => _sortBy = value!),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              FutureBuilder<List<Product>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final items = List<Product>.from(snapshot.data ?? []);
                  if (items.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('No products found',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ),
                    );
                  }

                  _sort(items);

                  return ProductGrid(products: items);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
