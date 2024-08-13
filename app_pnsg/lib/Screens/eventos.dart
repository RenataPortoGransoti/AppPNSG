import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'contribua.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';
import 'pastoraisScreen.dart';

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

  @override
  void initState() {
    super.initState();
    fetchEventos();
  }

  Future<void> fetchEventos() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}eventosapi'));
      if (response.statusCode == 200) {
        setState(() {
          eventos = json.decode(response.body);
          isLoading = false;
        });
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

  String formatDateTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  String formatDate(String dateTime) {
    final date = DateTime.parse(dateTime);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatTime(String dateTime) {
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
        color: Colors.blue[200], // Cor sólida para o indicador de refresh
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFF036896),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "EVENTOS PAROQUIAIS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: eventos.map<Widget>((evento) {
                return SizedBox(
                  width: 350, // Define a largura fixa para o card
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evento['nome_evento'],
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
                          Text(
                            'Fim: ${formatDate(evento['data_fim'])} ${formatTime(evento['data_fim'])}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Local: ${evento['local']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF036896),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            evento['descricao'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}




// ElevatedButton(
//   onPressed: () {
//     // Ação ao clicar em "Ver eventos salvos"
//   },
//   child: Text('Ver eventos salvos', style: TextStyle(
//     fontSize: 18,
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//   ),),
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.lightBlue,
//   ),
// ),