import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../config.dart';
import 'navigation_bar.dart';
import '../logger.dart';

class DizimoService {
  Future<Map<String, String?>?> fetchDizimoData() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}dizimoapi'));
    if (response.statusCode == 200) {
      List<dynamic> dizimos = json.decode(response.body);
      if (dizimos.isNotEmpty) {
        return {
          'chavePix': dizimos[0]['chavePix'],
          'QRCode': dizimos[0]['QRCode']
        };
      }
    } else {
      throw Exception('Falha ao carregar dízimos');
    }
    return null;
  }
}

class Dizimo extends StatefulWidget {
  const Dizimo({super.key});

  @override
  DizimoState createState() => DizimoState();
}

class DizimoState extends State<Dizimo> {
  String? chavePix;
  String? qrCodeUrl;
  bool isLoading = true;
  bool hasInternet = true;
  int currentPageIndex = 3;

  @override
  void initState() {
    super.initState();
    loadDizimo();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
        isLoading = false;
      });
    } else {
      setState(() {
        hasInternet = true;
      });
    }
  }

  Future<void> loadDizimo() async {
    try {
      await checkInternetConnection(); 
      final service = DizimoService();
      final fetchedData = await service.fetchDizimoData();
      setState(() {
        if (fetchedData != null) {
          chavePix = fetchedData['chavePix'];
          qrCodeUrl = fetchedData['QRCode'];
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      logger.i('Erro ao carregar dados do dízimo: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await loadDizimo();
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
                  "Dízimo",
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
                            "Sem acesso à internet. \n\nConecte-se para ver a chave pix para realizar a devolução do dízimo!",
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
                                        text: chavePix ??
                                            'Chave PIX não encontrada',
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
