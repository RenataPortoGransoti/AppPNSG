import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../logger.dart';
import 'navigation_bar.dart';
import 'tela_pastoral_especifica.dart';

class PastoraisScreen extends StatefulWidget {
  const PastoraisScreen({super.key});

  @override
  PastoraisScreenState createState() => PastoraisScreenState();
}

class PastoraisScreenState extends State<PastoraisScreen> {
  final PastoralService _pastoralService = PastoralService();
  List<dynamic> _pastorais = [];
  bool isLoading = true;
  bool hasInternet = true;
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(1);

  final List<String> _navigationHistory = [];

  void _onDestinationSelected(int index) {
    _selectedIndexNotifier.value = index;

    if (index != 1) {
      _navigationHistory.add(_getRouteName(index));
    }
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/Inicio');
        break;
      case 1:
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
    checkInternetConnection();
    _fetchPastorais();
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

  Future<void> _fetchPastorais() async {
    try {
      List<dynamic> pastorais = await _pastoralService.fetchPastorais();

      pastorais.sort((a, b) => a['nome'].compareTo(b['nome']));
      
      setState(() {
        _pastorais = pastorais;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      logger.i('Erro ao carregar dados das pastorais: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchPastorais();
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[200],
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Pastorais',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Pastoral é a ação da Igreja Católica no mundo ou o conjunto de atividades pelas quais a Igreja realiza a sua missão de continuar a ação de Jesus Cristo junto a diferentes grupos e realidades.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue[200],
              ),
            )
                : !hasInternet
                ? const Padding(
              padding: EdgeInsets.all(25),
              child:  Text(
                "Sem acesso à internet. Conecte-se para ver as pastorais ativas na paróquia!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            )
                : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _pastorais.length,
              itemBuilder: (context, index) {
                final pastoral = _pastorais[index];
                return _SampleCard(
                  cardName: pastoral['nome'],
                  descricao: pastoral['descricao'] ?? '',
                  imagem: pastoral['imagem'] ?? '',
                );
              },
            ),
          ],
        ),
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
    default: return -1;
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName, required this.descricao, required this.imagem});
  final String cardName;
  final String descricao;
  final String imagem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.lightBlue.shade100,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PastoralEspecifica(
                  nome: cardName,
                  descricao: descricao,
                  imagem: imagem,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  cardName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PastoralService {
  Future<List<dynamic>> fetchPastorais() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}api/pastoraisapi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar pastorais');
    }
  }
}
