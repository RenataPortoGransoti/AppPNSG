import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../inicio/tela_galeria.dart';
import '../inicio/tela_historia_paroquia.dart';
import '../inicio/tela_oracoes.dart';
import '../inicio/tela_via_sacra.dart';
import '../loginButton.dart';
import 'tela_login.dart';
import 'tela_eventos.dart';
import 'navigation_bar.dart';
import 'tela_pastorais.dart';
import 'tela_contribua.dart';
import 'tela_informacoes.dart';
import '../config.dart';

class Inicio extends StatefulWidget {
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  int currentPageIndex = 0;
  List<dynamic> avisos = [];
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkUser();
    fetchAvisos();
  }

  Future<void> _checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  Future<void> fetchAvisos() async {
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

  Future<void> _handleRefresh() async {
    await fetchAvisos();
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            color: Colors.blue[200],
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 10),
                  padding: const EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF036896),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.fiber_manual_record, size: 10, color: Colors.white),
                              const SizedBox(width: 5),
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
                SizedBox(height: 20),
                GridView.count(
                  padding: const EdgeInsets.all(30),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Oracoes()),
                        );
                      },
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 70),
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
                        constraints: const BoxConstraints(maxHeight: 70),
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
                        constraints: const BoxConstraints(maxHeight: 70),
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
                        constraints: const BoxConstraints(maxHeight: 70),
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
          _user == null
              ? LoginButton(
            onPressed: _navigateToLogin,
            buttonText: "Login",
          )
              : LoginButton(
            onPressed: _logout,
            buttonText: "Sair",
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