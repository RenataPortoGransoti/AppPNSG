import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'contribua.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

class PastoraisScreen extends StatefulWidget {
  @override
  _PastoraisScreenState createState() => _PastoraisScreenState();
}

class _PastoraisScreenState extends State<PastoraisScreen> {
  final PastoralService _pastoralService = PastoralService();
  List<dynamic> _pastorais = [];
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchPastorais();
  }

  Future<void> _fetchPastorais() async {
    try {
      List<dynamic> pastorais = await _pastoralService.fetchPastorais();
      setState(() {
        _pastorais = pastorais;
      });
    } catch (e) {
      print('Erro ao carregar dados das pastorais: $e');
    }
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
      body: Center(
        child: ListView.builder(
          itemCount: _pastorais.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Pastorais',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      'Pastoral é a ação da Igreja Católica no mundo ou o conjunto de atividades pelas quais a Igreja realiza a sua missão de continuar a ação de Jesus Cristo junto a diferentes grupos e realidades.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 1),
                ],
              );
            } else {
              final pastoral = _pastorais[index - 1];


              return _SampleCard(
                cardName: pastoral['nome'],
                descricao: pastoral['descricao'] ?? '',
                imagem: pastoral['imagem']?? '',
              );
            }
          },
        ),
      ),
    );
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
            Navigator.pushNamed(
              context,
              '/PastoralEspecifica',
              arguments: {
                'nome': cardName,
                'descricao': descricao,
                'imagem': imagem,
              },
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
    final response = await http.get(Uri.parse('http://10.20.1.95:8000/pastoraisapi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar pastorais');
    }
  }
}




//10.20.1.95

//192.168.1.5:8000