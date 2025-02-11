import 'package:flutter/material.dart';

/// A customizable circular icon button with tap effects.
class CircularIconButton extends StatefulWidget {
  /// Creates a [CircularIconButton].
  const CircularIconButton({
    required this.icon, required this.onTap, super.key,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.size = 60.0,
  });
  /// The icon to be displayed within the button.
  final IconData icon;

  /// Callback function when the button is tapped.
  final VoidCallback onTap;

  /// Color of the icon.
  final Color iconColor;

  /// Background color of the button.
  final Color backgroundColor;

  /// The size (diameter) of the button.
  final double size;

  @override
  State<CircularIconButton> createState() => _CircularIconButtonState();
}

class _CircularIconButtonState extends State<CircularIconButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap(); // Call the function after the press effect
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isPressed
                ? widget.iconColor
                : widget.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isPressed ? 0.6 : 0.3),
                blurRadius: _isPressed ? 15 : 10,
                spreadRadius: _isPressed ? 3 : 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: widget.size * 0.5,
              color:_isPressed
                ? widget.backgroundColor
                : widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
