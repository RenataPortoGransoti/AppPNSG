import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/doacao_controller.dart';
import '../models/doacao_model.dart';
import '../config.dart';
import 'widgets/header_widget.dart';

class DoacaoScreen extends StatefulWidget {
  const DoacaoScreen({Key? key}) : super(key: key);

  @override
  _DoacaoScreenState createState() => _DoacaoScreenState();
}

class _DoacaoScreenState extends State<DoacaoScreen> {
  final DoacaoController _controller = DoacaoController();
  DoacaoModel? _doacaoData;
  bool _isLoading = true;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _loadDoacaoData();
  }

  Future<void> _loadDoacaoData() async {
    try {
      final doacaoData = await _controller.fetchDizimoData();
      setState(() {
        _doacaoData = doacaoData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _copyToClipboard(String chavePix) {
    Clipboard.setData(ClipboardData(text: chavePix));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chave Pix copiada para a área de transferência!')),
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
            const HeaderWidget(title: "Doação"),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : _doacaoData != null
                ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chave Pix: ${_doacaoData!.chavePix ?? 'Não disponível'}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.black),
                      onPressed: () {
                        if (_doacaoData!.chavePix != null) {
                          _copyToClipboard(_doacaoData!.chavePix!);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_doacaoData!.qrCode != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      '${Config.baseUrl}storage/${_doacaoData!.qrCode!}',
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