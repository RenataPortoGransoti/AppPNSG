import 'dart:convert';
import 'package:PNSG/Screens/tela_pastorais.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // Importado para Clipboard
import '../config.dart';
import 'tela_contribua.dart';
import 'tela_eventos.dart';
import 'tela_informacoes.dart';
import 'tela_inicio.dart';
import 'navigation_bar.dart';

class DoacaoService {
  Future<Map<String, String?>?> fetchDoacaoData() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}doacaoapi'));
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
  @override
  _DoacaoState createState() => _DoacaoState();
}

class _DoacaoState extends State<Doacao> {
  String? chavePix;
  String? qrCodeUrl;
  bool isLoading = true;
  int currentPageIndex = 3;
  @override
  void initState() {
    super.initState();
    loadDoacao();
  }

  Future<void> loadDoacao() async {
    try {
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
        isLoading = false;
      });
      print('Erro ao carregar dados do doação: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await loadDoacao();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chave Pix copiada para a área de transferência!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomNavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          if (currentPageIndex == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inicio()),
            );
          } else if (currentPageIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PastoraisScreen()),
            );
          } else if (currentPageIndex == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Eventos()),
            );
          } else if (currentPageIndex == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contribua()),
            );
          }
          else if (currentPageIndex == 4) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Informacoes())
            );
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
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF036896),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Doação",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              if (isLoading)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Ajusta o tamanho do Row
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Chave pix: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Ajustar a cor do texto
                                ),
                              ),
                              TextSpan(
                                text: chavePix ?? 'Chave PIX não encontrada',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Ajustar a cor do texto
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // Espaço entre o texto e o ícone
                        IconButton(
                          icon: Icon(Icons.copy),
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
              SizedBox(height: 20),
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
