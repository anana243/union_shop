import 'package:flutter/material.dart';

class FooterSubscribeBox extends StatefulWidget {
  const FooterSubscribeBox({super.key});

  @override
  State<FooterSubscribeBox> createState() => _FooterSubscribeBoxState();
}

class _FooterSubscribeBoxState extends State<FooterSubscribeBox> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) => RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v);

  void _subscribe() {
    final ok = _isValidEmail(_email.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Subscribed! Check your inbox.' : 'Please enter a valid email address')),
    );
    if (ok) _email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LATEST OFFERS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email address',
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Color(0xFF4d2963)),
              ),
            ),
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity, height: 40,
            child: ElevatedButton(
              onPressed: _subscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('SUBSCRIBE', style: TextStyle(fontSize: 12, letterSpacing: 0.8)),
            ),
          ),
        ],
      ),
    );
  }
}