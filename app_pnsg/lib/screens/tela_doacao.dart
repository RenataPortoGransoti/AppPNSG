import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../config.dart';
import 'navigation_bar.dart';
import '../logger.dart';

class DoacaoService {
  Future<Map<String, String?>?> fetchDoacaoData() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}api/doacaoapi'));
    if (response.statusCode == 200) {
      List<dynamic> doacao = json.decode(response.body);
      if (doacao.isNotEmpty) {
        return {
          'chavePix': doacao[0]['chavePix'],
          'QRCode': doacao[0]['QRCode']
        };
      }
    } else {
      throw Exception('Falha ao carregar doação');
    }
    return null;
  }
}

class Doacao extends StatefulWidget {
  const Doacao({super.key});

  @override
  DoacaoState createState() => DoacaoState();
}

class DoacaoState extends State<Doacao> {
  String? chavePix;
  String? qrCodeUrl;
  bool isLoading = true;
  bool hasInternet = true; // Variável para controlar a conexão com a internet
  int currentPageIndex = 3;

  @override
  void initState() {
    super.initState();
    loadDoacao();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false; // Não há conexão
        isLoading = false; // Para parar o carregamento
      });
    } else {
      setState(() {
        hasInternet = true; // Há conexão
      });
    }
  }

  Future<void> loadDoacao() async {
    try {
      await checkInternetConnection(); // Verificar conexão antes de carregar os dados
      final service = DoacaoService();
      final fetchedData = await service.fetchDoacaoData();
      setState(() {
        if (fetchedData != null) {
          chavePix = fetchedData['chavePix'];
          qrCodeUrl = fetchedData['QRCode'];
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Para parar o carregamento em caso de erro
      });
      logger.i('Erro ao carregar dados do doação: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await loadDoacao();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chave Pix copiada para a área de transferência!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            switch (currentPageIndex) {
              case 0:
                Navigator.pushNamed(context, '/Inicio');
                break;
              case 1:
                Navigator.pushNamed(context, '/PastoraisScreen');
                break;
              case 2:
                Navigator.pushNamed(context, '/Eventos');
                break;
              case 3:
                Navigator.pushNamed(context, '/Contribua');
                break;
              case 4:
                Navigator.pushNamed(context, '/Informacoes');
                break;
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[200],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF036896),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Doação",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue[200],
                      ),
                    )
                  : !hasInternet
                      ? const Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Sem acesso à internet. \n\nConecte-se para ver a chave pix para realizar a doação!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Chave pix: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: chavePix ?? 'Chave PIX não encontrada',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    if (chavePix != null) {
                                      _copyToClipboard(chavePix!);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
              const SizedBox(height: 20),
              if (qrCodeUrl != null && qrCodeUrl!.isNotEmpty)
                Center(
                  child: Image.network(
                    _buildImageUrl(qrCodeUrl!),
                    width: 230,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildImageUrl(String path) {
    return '${Config.baseUrl}storage/$path';
  }
}
