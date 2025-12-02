import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  const HoverText({super.key, required this.text});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Text(
        widget.text,
        style: TextStyle(
          color: isHovering ? Colors.grey[700] : Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}