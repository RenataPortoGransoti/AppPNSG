import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Inicio/galeria.dart';
import '../Inicio/historiaParoquia.dart';
import '../Inicio/oracoes.dart';
import '../Inicio/viaSacra.dart';
import 'eventos.dart';
import 'navigation_bar.dart';
import 'pastoraisScreen.dart';
import 'contribua.dart';
import 'informacoes.dart';

class Inicio extends StatefulWidget {
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  int currentPageIndex = 0;

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
                  MaterialPageRoute(
                      builder: (context) => Informacoes()));
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20, right: 20, top: 60, bottom: 10),
            padding: const EdgeInsets.all(58),
            width: MediaQuery.of(context).size.width - 70,
            decoration: BoxDecoration(
              color: Color(0xFF036896),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "Avisos Paroquiais",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: WebView(
                      initialUrl: 'https://liturgia.cancaonova.com/pb/',
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
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
