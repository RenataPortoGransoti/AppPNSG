import 'package:PNSG/views/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/dizimo_controller.dart';
import '../models/dizimo_model.dart';
import '../config.dart';

class DizimoScreen extends StatefulWidget {
  const DizimoScreen({Key? key}) : super(key: key);

  @override
  _DizimoScreenState createState() => _DizimoScreenState();
}

class _DizimoScreenState extends State<DizimoScreen> {
  final DizimoController _controller = DizimoController();
  DizimoModel? _dizimoData;
  bool _isLoading = true;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _loadDizimo();
  }

  Future<void> _loadDizimo() async {
    try {
      final dizimoData = await _controller.fetchDizimoData();
      setState(() {
        _dizimoData = dizimoData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _copyToClipboard(String chavePix) {
    Clipboard.setData(ClipboardData(text: chavePix));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chave Pix copiada!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const HeaderWidget(title: "Dízimo"),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : _dizimoData != null
                ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chave Pix: ${_dizimoData!.chavePix ?? 'Não disponível'}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.black),
                      onPressed: () {
                        if (_dizimoData!.chavePix != null) {
                          _copyToClipboard(_dizimoData!.chavePix!);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_dizimoData!.qrCode != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      '${Config.baseUrl}storage/${_dizimoData!.qrCode!}',
                      width: 200,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) =>
                      const Text('Erro ao carregar imagem do QR Code'),
                    ),
                  ),
              ],
            )
                : const Text("Erro ao carregar os dados."),
          ],
        ),
      ),
    );
  }
}