import 'package:flutter/material.dart';

class ChefBadge extends StatelessWidget {
  final double size;

  const ChefBadge({super.key, this.size = 18.0});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.verified_rounded,
      color: const Color(0xFF1DA1F2),
      size: size,
    );
  }
}
