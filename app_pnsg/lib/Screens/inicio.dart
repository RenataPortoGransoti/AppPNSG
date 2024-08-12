import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Inicio/galeria.dart';
import '../Inicio/historiaParoquia.dart';
import '../Inicio/oracoes.dart';
import '../Inicio/viaSacra.dart';
import '../config.dart';
import 'eventos.dart';
import 'navigation_bar.dart';
import 'pastoraisScreen.dart';
import 'contribua.dart';
import 'informacoes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Inicio extends StatefulWidget {
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  int currentPageIndex = 0;
  List<dynamic> avisos = [];

  @override
  void initState() {
    super.initState();
    fetchAvisos();
  }

  void fetchAvisos() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}avisosapi'));

      if (response.statusCode == 200) {
        setState(() {
          avisos = json.decode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar os avisos');
      }
    } catch (e) {
      print('Erro ao carregar os avisos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (currentPageIndex == 1) {
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 10),
            padding: const EdgeInsets.all(18),
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: Color(0xFF036896),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  "AVISOS PAROQUIAIS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                if (avisos.isEmpty)
                  Text(
                    'Não há avisos disponíveis no momento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                for (var aviso in avisos)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center, // Ajuste aqui
                      children: [
                        Icon(Icons.fiber_manual_record, size: 10, color: Colors.white),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            aviso['aviso'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GridView.count(
                    padding: const EdgeInsets.all(30),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Oracoes()),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 70),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Orações",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Galeria()),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 70),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Galeria',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViaSacra()),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 70),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Via Sacra",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistoriaParoquia()),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 70),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'História da Paróquia',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//aparecer janela web com a liturgia diária
/*Container(
 height: MediaQuery.of(context).size.height - 200,
 child: WebView(
 initialUrl: 'https://liturgia.cancaonova.com/pb/',
 javascriptMode: JavascriptMode.unrestricted,

 */