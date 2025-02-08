import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_domain/coffee_domain.dart';
import 'package:flutter/material.dart';

class CoffeeImageView extends StatelessWidget {
  const CoffeeImageView({
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          // Use CachedNetworkImage
          imageUrl: coffee.imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(), // Loading placeholder
          errorWidget: (context, url, error) => const Icon(Icons.error), // Error widget
          fit: BoxFit.cover, // Or BoxFit.contain, depending on your needs
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () => onFavoriteToggled(coffee),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
          ],
        ),
      ],
    );
  }
}
