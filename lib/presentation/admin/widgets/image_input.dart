import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
    this.imageURL,
    this.imageFilePath,
  });

  final String imageURL;
  final String imageFilePath;

  @override
  Widget build(BuildContext context) {
    Widget imagePreview = const Text("Select a image");

    if (imageURL != null) {
      imagePreview = CachedNetworkImage(
        imageUrl: imageURL,
      );
    } else if (imageFilePath != null) {
      imagePreview = Image.file(
        File(imageFilePath),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: imagePreview,
    );
  }
}
