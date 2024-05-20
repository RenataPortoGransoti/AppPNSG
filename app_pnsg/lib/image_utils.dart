import 'package:flutter/material.dart';

class ImageUtils {
  static Future<Widget?> loadImage(BuildContext context, String imagePath, {double? height}) async {
    try {
      // Carrega a imagem da rede
      final image = Image.network(imagePath, height: height);

      // Espera até que a imagem seja carregada
      await precacheImage(NetworkImage(imagePath), context);

      return image;
    } catch (e) {
      // Em caso de erro, retorna null
      print('Erro ao carregar imagem: $e');
      return null;
    }
  }
}
