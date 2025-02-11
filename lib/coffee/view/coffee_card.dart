import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:flutter/material.dart';

class CoffeeCard extends StatefulWidget {
  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.isFavorite,
    required this.onRefresh,
    required this.onFavoriteToggled,
  });
  final Coffee coffee;
  final bool isFavorite;
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
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          widget.onRefresh(); // Refresh on swipe down
        }
      },
      child: Dismissible(
        key: ValueKey(widget.coffee.id),
        direction: DismissDirection.horizontal, // Allow left & right swipe
        onDismissed: _onDismiss,
        background: _buildSwipeBackground(Alignment.centerLeft, Colors.green, Icons.favorite), // Right swipe background
        secondaryBackground: _buildSwipeBackground(Alignment.centerRight, Colors.red, Icons.close), // Left swipe background
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: widget.coffee.imageUrl,
                    height: 500,
                    width: 350,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 500,
                      width: 350,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 40, color: Colors.red),
                  ),
                ),
              ),

              // Gradient overlay
              Positioned(
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
              ),

              // Action Buttons
              Positioned(
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.refresh, widget.onRefresh, Colors.blueAccent),
                    const SizedBox(width: 20),
                    _buildActionButton(
                      widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                      () => widget.onFavoriteToggled(widget.coffee),
                      widget.isFavorite ? Colors.red : Colors.white,
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

  Widget _buildActionButton(IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, size: 30, color: color),
      ),
    );
  }

  Widget _buildSwipeBackground(Alignment alignment, Color color, IconData icon) {
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
