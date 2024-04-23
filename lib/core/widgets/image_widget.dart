import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proteam_app/core/theme/color_style.dart';

// Enum to represent the different types of images
enum ImageType { profile, food, meal }

Widget imageWidget({String? imageUrl, File? image, ImageType imageType = ImageType.profile}) {
  final Widget img;

  // Check if an image was selected
  if (image != null) {
    // Return selected image from gallery
    img = Image.file(
      image,
      fit: BoxFit.cover,
    );
  } else {
    // If an image was not selected, check if an image url was provided
    if (imageUrl == null || imageUrl == "") {
      // If no image url was provided, return the default image
      img = _getDefaultImage(imageType);
    } else {
      // Show the image using the image url and keep it in the cache directory (using cached_network_image package)
      img = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const CircularProgressIndicator(
            color: boneColor,
          );
        },
        // If an error occurs using the image url, return the default image
        errorWidget: (context, url, error) => _getDefaultImage(imageType)
      );
    }
  }

  // Return the image
  return img;
}

// Helper function to get the default image based on type
Widget _getDefaultImage(ImageType type) {
  switch (type) {
    case ImageType.profile:
      return Image.asset(
        'assets/profile_default.png',
        fit: BoxFit.cover,
      );
    case ImageType.food:
      return const Icon(Icons.dinner_dining, size: 110,);
    case ImageType.meal:
      return const Icon(Icons.dinner_dining, size: 110);
    default:
      return const Icon(Icons.image, size: 110);
  }
}
