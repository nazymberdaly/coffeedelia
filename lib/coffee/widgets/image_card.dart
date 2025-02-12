import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A card widget that displays an image with caching support.
class ImageCard extends StatelessWidget {
  /// Creates an [ImageCard].
  const ImageCard({required this.imageUrl, super.key});
 
  /// The URL of the image to be displayed.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 500,
          width: 350,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildLoadingIndicator(),
          errorWidget: (context, url, error) => _buildErrorIcon(),
        ),
      ),
    );
  }

  /// Builds a loading indicator while the image is loading
  Widget _buildLoadingIndicator() {
    return Container(
      height: 500,
      width: 350,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  /// Builds an error icon in case the image fails to load
  Widget _buildErrorIcon() {
    return const Icon(Icons.error, size: 40, color: Colors.red);
  }
}
