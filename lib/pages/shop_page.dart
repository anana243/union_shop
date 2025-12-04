import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../services/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';

class ShopPage extends StatefulWidget {
  final String? initialFilter;
  const ShopPage({super.key, this.initialFilter});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  static const List<_Filter> _filters = [
    _Filter('All Products', null),
    _Filter('Clothing', 'clothing'),
    _Filter('Merchandise', 'merchandise'),
    _Filter('Portsmouth City Collection', 'city'),
    _Filter('Pride Collection', 'pride'),
    _Filter('Graduation Collection', 'graduation'),
    _Filter('Signature Range', 'signature'),
    _Filter('Essential Range', 'essential'),
  ];

  late String _filterBy;
  String _sortBy = 'Featured';
  late final ProductRepository _repo;
  Future<List<Product>>? _future;

  @override
  void initState() {
    super.initState();
    _repo = ProductRepository();
    
    // Use initialFilter if provided, otherwise default to 'All Products'
    _filterBy = widget.initialFilter ?? _filters.first.label;
    _future = _load();
  }

  Future<List<Product>> _load() {
    final f = _filters.firstWhere((e) => e.label == _filterBy);
    if (f.collection == null) return _repo.listAll(limit: 100);
    return _repo.listByCollection(f.collection!);
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
              Text(
                _filterBy,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text('Filter by:', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                      value: _filterBy,
                      underline: Container(),
                      items: _filters
                          .map((f) => DropdownMenuItem(
                                value: f.label,
                                child: Text(f.label),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                            _filterBy = value!;
                            _future = _load();
                          }),
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
                            value: 'A-Z', child: Text('Alphabetically, A-Z')),
                        DropdownMenuItem(
                            value: 'Z-A', child: Text('Alphabetically, Z-A')),
                        DropdownMenuItem(
                            value: 'Price Low',
                            child: Text('Price, Low to High')),
                        DropdownMenuItem(
                            value: 'Price High',
                            child: Text('Price, High to Low')),
                      ],
                      onChanged: (value) => setState(() => _sortBy = value!),
                    ),
                    // Avoid Spacer in horizontal scroll; add small gap
                    const SizedBox(width: 24),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('${items.length} products',
                            style: const TextStyle(fontSize: 14)),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 24,
                    runSpacing: 24,
                    children: items
                        .map((p) => ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 240),
                              child: ProductTile(product: p),
                            ))
                        .toList(),
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

class _Filter {
  final String label;
  final String? collection;
  const _Filter(this.label, this.collection);
}
