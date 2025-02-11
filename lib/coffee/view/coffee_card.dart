import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:coffeedelia/coffee/coffee.dart';
import 'package:coffeedelia/coffee/view/widgets/image_card.dart';
import 'package:flutter/material.dart';

class CoffeeCard extends StatefulWidget {
  const CoffeeCard({
    required this.coffee,
    required this.onRefresh,
    required this.onFavoriteToggled,
    super.key,
  });
  final Coffee coffee;
  final VoidCallback onRefresh;
  final void Function(Coffee) onFavoriteToggled;

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  void _onDismiss(DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      // Swipe Left - Dismiss
      widget.onRefresh();
    } else if (direction == DismissDirection.startToEnd) {
      // Swipe Right - Add to Favorites
      widget.onFavoriteToggled(widget.coffee);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Dismissible(
        key: ValueKey(widget.coffee.id),
        onDismissed: _onDismiss,
        background: const SwipeBackground(
          alignment: Alignment.centerLeft,
          color: Colors.green,
          icon: Icons.favorite,
        ), // Right swipe background
        secondaryBackground: const SwipeBackground(
          alignment: Alignment.centerRight,
          color: Colors.red,
          icon: Icons.close,
        ), // Left swipe background
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ImageCard(imageUrl: widget.coffee.imageUrl),

              // Gradient overlay
              _buildGradientOverlay(),

              // Action Buttons
              Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularIconButton(
                      icon: Icons.refresh,
                      onTap: widget.onRefresh,
                      iconColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    CircularIconButton(
                      icon: Icons.favorite,
                      onTap: () => widget.onFavoriteToggled(widget.coffee),
                      iconColor: Colors.red,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the gradient overlay for better text visibility
  Widget _buildGradientOverlay() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 350,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
