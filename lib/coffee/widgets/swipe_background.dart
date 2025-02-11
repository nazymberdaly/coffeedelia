import 'package:flutter/material.dart';

/// A widget that displays a colored background with an icon
class SwipeBackground extends StatelessWidget {
   /// Creates a [SwipeBackground].
  const SwipeBackground({
    required this.alignment,
    required this.color,
    required this.icon,
    super.key,
  });
  /// The alignment of the icon within the container.
  final Alignment alignment;

   /// The background color of the container.
  final Color color;

  /// The icon to display.
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
