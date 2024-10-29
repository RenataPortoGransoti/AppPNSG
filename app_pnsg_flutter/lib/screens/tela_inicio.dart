import 'dart:convert';
import '../config.dart';
import 'package:http/http.dart' as http;
import 'package:PNSG/Screens/tela_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_button.dart';
import 'inicio/tela_galeria.dart';
import 'navigation_bar.dart';
import 'Inicio/tela_historia_paroquia.dart';
import 'Inicio/tela_oracoes.dart';
import 'Inicio/tela_via_sacra.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {
  int currentPageIndex = 0;
  List<dynamic> avisos = [];
  User? _user;
  ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  final List<String> _navigationHistory = [];

  void _onDestinationSelected(int index) {
    _selectedIndexNotifier.value = index;

    if (index != 1) {
      _navigationHistory.add(_getRouteName(index));
    }
    switch (index) {
      case 0:
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
  }

  String _getRouteName(int index) {
    switch (index) {
      case 0: return '/Inicio';
      case 1: return '/Pastorais';
      case 2: return '/Eventos';
      case 3: return '/Contribua';
      case 4: return '/Informações';
      default: return '';
    }
  }

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
      final response = await http.get(Uri.parse('${Config.baseUrl}api/avisosapi'));

      if (response.statusCode == 200) {
        setState(() {
          avisos = json.decode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar os avisos');
      }
    } catch (e) {
      throw Exception('Falha ao carregar os avisos');
    }
  }

  Future<void> _handleRefresh() async {
    await fetchAvisos();
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
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
    return WillPopScope(
        onWillPop: () async {
      if (_navigationHistory.isNotEmpty) {
        String previousRoute = _navigationHistory.removeLast();
        int previousIndex = _getIndexFromRoute(previousRoute);
        _selectedIndexNotifier.value = previousIndex;
        Navigator.pushReplacementNamed(context, previousRoute);
        return false;
      } else {
        return true;
      }
    },
    child: Scaffold(
    bottomNavigationBar: CustomBottomNavigationBar(
    onDestinationSelected: _onDestinationSelected,
    selectedIndex: _selectedIndexNotifier.value,
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 10),
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
                      const SizedBox(height: 10),
                      if (avisos.isEmpty)
                        const Text(
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
                                  style: const TextStyle(
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
                const SizedBox(height: 20),
                GridView.count(
                  padding: const EdgeInsets.all(30),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Oracoes()),
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
                          MaterialPageRoute(builder: (context) => const Galeria()),
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
                          MaterialPageRoute(builder: (context) => const ViaSacra()),
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
                          MaterialPageRoute(builder: (context) => const HistoriaParoquia()),
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
          //saudação ao usuário logado
          // if (_user != null)
          //   Positioned(
          //     top: 40.0,
          //     left: 20,
          //     child: Text(
          //       "Seja bem-vindo(a), ${_user?.displayName?.split(' ')[0] ?? 'Usuário'}!",
          //       style: const TextStyle(
          //         fontSize: 14,
          //       ),
          //     ),
          //   ),
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
    ),);
  }
}

int _getIndexFromRoute(String route) {
  switch (route) {
    case '/Inicio': return 0;
    case '/Pastorais': return 1;
    case '/Eventos': return 2;
    case '/Contribua': return 3;
    case '/Informações': return 4;
    default: return -1; // Valor padrão se a rota não for encontrada
  }
}

//aparecer janela web com a liturgia diária
/*Container(
 height: MediaQuery.of(context).size.height - 200,
 child: WebView(
 initialUrl: 'https://liturgia.cancaonova.com/pb/',
 javascriptMode: JavascriptMode.unrestricted,
)
 */