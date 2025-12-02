import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) => const AppLayout(title: 'Union', child: Center(child: Text('Search Page Content')));

  // This trailing comma makes auto-formatting nicer in code editors.
}