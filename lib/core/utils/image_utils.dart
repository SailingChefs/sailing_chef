import 'package:flutter/material.dart';

/// Utility class for safe image loading operations throughout the app
class ImageUtils {
  /// Default fallback image path
  static const String placeholderImage = 'assets/images/placeholder.png';

  static const String placeholderImageAvatar = 'assets/images/icons/avatar.png';

  /// Checks if a URL string is valid for network image loading
  static bool isValidImageUrl(String? url) {
    if (url == null || url.isEmpty || url.trim().isEmpty) return false;

    // Check if it's a valid URL format
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Returns a safe ImageProvider with fallback to asset image
  static ImageProvider<Object> safeNetworkImage(String? imageUrl) {
    if (isValidImageUrl(imageUrl)) {
      return NetworkImage(imageUrl!);
    }
    return AssetImage(placeholderImage);
  }

  /// Returns a safe ImageProvider for CircleAvatar with null handling
  static ImageProvider<Object> safeNetworkImageForAvatar(String? imageUrl) {
    if (isValidImageUrl(imageUrl)) {
      return NetworkImage(imageUrl!);
    }
    return AssetImage(placeholderImageAvatar);
  }

  /// Checks if the image URL is valid and not empty, returns null if invalid
  static ImageProvider<Object>? conditionalNetworkImage(String? imageUrl) {
    if (isValidImageUrl(imageUrl)) {
      return NetworkImage(imageUrl!);
    }
    return null;
  }

  /// Creates a network image widget with error handling
  static Widget networkImageWithFallback({
    required String? imageUrl,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    Widget imageWidget = isValidImageUrl(imageUrl)
        ? Image.network(
            imageUrl!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                placeholderImage,
                width: width,
                height: height,
                fit: fit,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          )
        : Image.asset(
            placeholderImage,
            width: width,
            height: height,
            fit: fit,
          );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
