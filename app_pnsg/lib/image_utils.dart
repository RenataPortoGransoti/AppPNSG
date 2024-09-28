import 'package:flutter/material.dart';

class ImageUtils {
  static Future<Widget?> loadImage(BuildContext context, String imagePath, {double? height}) async {
    try {
      final image = Image.network(imagePath, height: height);
      await precacheImage(NetworkImage(imagePath), context);
      return image;
    } catch (e) {
      return null;
    }
  }
}
