import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the package

class CoffeeImageWidget extends StatelessWidget {
  final CoffeeImage coffeeImage;
  final bool isFavorite;
  final VoidCallback onRefresh;
  final Function(CoffeeImage) onFavoriteToggled;

  const CoffeeImageWidget({
    super.key,
    required this.coffeeImage,
    required this.isFavorite,
    required this.onRefresh,
    required this.onFavoriteToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage( // Use CachedNetworkImage
          imageUrl: coffeeImage.url,
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
              onPressed: () => onFavoriteToggled(coffeeImage),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
          ],
        ),
      ],
    );
  }
}