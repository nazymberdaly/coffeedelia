import 'package:flutter/material.dart';

class SwipeBackground extends StatelessWidget {
  const SwipeBackground({
    required this.alignment,
    required this.color,
    required this.icon,
    super.key,
  });
  final Alignment alignment;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 40),
    );
  }
}
