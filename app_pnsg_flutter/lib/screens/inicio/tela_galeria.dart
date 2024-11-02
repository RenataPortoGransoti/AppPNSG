import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../views/widgets/header_widget.dart'; // Certifique-se de importar o pacote correto

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
          const HeaderWidget(title: "Galeria"),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}