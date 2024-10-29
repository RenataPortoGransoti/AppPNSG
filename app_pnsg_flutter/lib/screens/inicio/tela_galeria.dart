import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Certifique-se de importar o pacote correto

class Galeria extends StatefulWidget {
  const Galeria({super.key});

  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  late final WebViewController _controller;

  final String googleDriveFolderUrl =
      'https://drive.google.com/drive/folders/1ODlccrNq4HvXXGopNoFjSSOvSEd3Agvk?usp=sharing';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(googleDriveFolderUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF036896).withOpacity(0.8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Galeria',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}