import 'package:flutter/material.dart';
import '../app_layout.dart';

class PersonalizationPage extends StatefulWidget {
  const PersonalizationPage({super.key});

  @override
  State<PersonalizationPage> createState() => _PersonalizationPageState();
}

class _PersonalizationPageState extends State<PersonalizationPage> {
  String _selectedOption = '1 Line of Text';

  final Map<String, double> _priceMap = {
    '1 Line of Text': 3.00,
    '2 Lines of Text': 5.00,
    '3 Lines of Text': 7.00,
    '4 Lines of Text': 9.00,
    'Small Logo': 8.00,
    'Large Logo': 12.00,
  };

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
