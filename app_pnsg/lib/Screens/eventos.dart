import 'dart:convert';
import 'package:PNSG/Screens/pastoraisScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../database_helper.dart';
import 'contribua.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'saved_events.dart';
import '../config.dart';
import 'navigation_bar.dart';

class Eventos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventosState();
  }
}

class EventosState extends State<Eventos> {
  int currentPageIndex = 2;
  List<dynamic> eventos = [];
  bool isLoading = true;
  bool hasInternet = true;
  User? user;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    fetchEventos();
    _getUser();
  }

  // Função para verificar se há conexão à internet
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

  Future<void> fetchEventos() async {
    await checkInternetConnection();
    if (!hasInternet) return;

    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}eventosapi'));
      if (response.statusCode == 200) {
        setState(() {
          eventos = json.decode(response.body);
          isLoading = false;
        });
        print('Eventos carregados: $eventos');
      } else {
        throw Exception('Falha ao carregar eventos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Future<void> _handleRefresh() async {
    await fetchEventos();
  }

  Future<void> _getUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

  Future<void> _saveEvent(String eventId, Map<String, dynamic> eventData) async {
    if (user != null) {
      final eventToSave = {
        'id': eventId.toString(),
        'nome_evento': eventData['nome_evento'] ?? 'Nome não informado',
        'data_inicio': eventData['data_inicio'] ?? 'Data não informada',
        'data_fim': eventData['data_fim'] ?? 'Data não informada',
        'local': eventData['local'] ?? 'Local não informado',
        'descricao': eventData['descricao'] ?? 'Descrição não informada',
      };

      print('Tentando salvar evento: $eventToSave');

      try {
        await DatabaseHelper().saveEvent(eventToSave);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Evento salvo com sucesso!')),
        );
      } catch (e) {
        print('Erro ao salvar evento: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar evento.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você precisa estar logado para salvar eventos.')),
      );
    }
  }

  String formatDate(String? dateTime) {
    if (dateTime == null) return 'Data não disponível';
    final date = DateTime.parse(dateTime);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatTime(String? dateTime) {
    if (dateTime == null) return 'Hora não disponível';
    final date = DateTime.parse(dateTime);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
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
            } else if (currentPageIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contribua()),
              );
            } else if (currentPageIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Informacoes()),
              );
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[200], // Cor alterada para azul
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              margin: EdgeInsets.only(left: 14, right: 14, top: 56, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF036896),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "EVENTOS PAROQUIAIS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedEvents()),
                );
              },
              child: Text(
                'Ver eventos salvos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 2.0, color: Colors.lightBlue),
              ),
            ),

            SizedBox(height: 10.0),
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue[200],
                ),
              )
                  : !hasInternet
                  ? Center(
                child: Text(
                  "Sem acesso à internet",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return SizedBox(
                    width: 380,
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.blue[100]!, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  evento['nome_evento'] ?? 'Nome do Evento',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Início: ${formatDate(evento['data_inicio'])} ${formatTime(evento['data_inicio'])}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                if (evento['data_fim'] != null)
                                  Text(
                                    'Fim: ${formatDate(evento['data_fim'])} ${formatTime(evento['data_fim'])}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                SizedBox(height: 8),
                                Text(
                                  'Local: ${evento['local'] ?? 'Local não disponível'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  evento['descricao'] ?? 'Descrição do evento não disponível.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.bookmark,
                                  size: 30,
                                  color: Colors.blue[300],
                                ),
                                onPressed: () {
                                  _saveEvent(evento['id'].toString(), evento);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
