import 'package:flutter/material.dart';
import '../app_layout.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class PersonalizationPage extends StatefulWidget {
  const PersonalizationPage({super.key});

  @override
  State<PersonalizationPage> createState() => _PersonalizationPageState();
}

class _PersonalizationPageState extends State<PersonalizationPage> {
  String _selectedOption = '1 Line of Text';
  final _textController = TextEditingController();
  int _quantity = 1;

  final Map<String, double> _priceMap = {
    '1 Line of Text': 3.00,
    '2 Lines of Text': 5.00,
    '3 Lines of Text': 7.00,
    '4 Lines of Text': 9.00,
    'Small Logo': 8.00,
    'Large Logo': 12.00,
  };

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addToCart() {
    if (_textController.text.trim().isEmpty && !_selectedOption.contains('Logo')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your personalization text')),
      );
      return;
    }

    final product = Product(
      id: 'personalization-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Personalization - $_selectedOption${_textController.text.isNotEmpty ? ": ${_textController.text}" : ""}',
      imageUrl: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      price: _priceMap[_selectedOption]!,
      slug: 'personalization',
    );

    for (int i = 0; i < _quantity; i++) {
      CartService.instance.add(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity personalization item(s) to cart'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _textController.clear();
      _quantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return AppLayout(
      title: 'Union',
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: EdgeInsets.all(isMobile ? 16 : 48),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                if (!isMobile) ...[
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personalization',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '£${_priceMap[_selectedOption]!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Selection',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedOption,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        items: _priceMap.keys.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              '$option - £${_priceMap[option]!.toStringAsFixed(2)}',
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedOption = value!);
                        },
                      ),
                      const SizedBox(height: 24),
                      if (!_selectedOption.contains('Logo')) ...[
                        const Text(
                          'Personalization Text',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedOption == '1 Line of Text'
                              ? 'Maximum 10 characters'
                              : 'Enter your text',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _textController,
                          maxLength: _selectedOption == '1 Line of Text' ? 10 : null,
                          maxLines: _selectedOption.contains('Line')
                              ? int.parse(_selectedOption.split(' ')[0])
                              : 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your text here',
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_quantity > 1) {
                                setState(() => _quantity--);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() => _quantity++);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'ADD TO CART',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          border: Border.all(color: Colors.orange[200]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.orange[800]),
                                const SizedBox(width: 8),
                                Text(
                                  'Important Notice',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Please ensure all spelling is correct before submitting your purchase, as we will print your item with the exact wording you provide. We will not be responsible for any incorrect spellings printed on your garment. Personalized items do not qualify for refunds.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
