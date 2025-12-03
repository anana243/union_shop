import 'package:flutter/material.dart';
import '../app_layout.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
