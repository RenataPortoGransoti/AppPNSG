import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';
import 'pastoralEspecifica.dart'; // Importa a tela PastoralEspecifica

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

  Future<void> _handleRefresh() async {
    await _fetchPastorais();
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
                imagem: pastoral['imagem'] ?? '',
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
    final response = await http.get(Uri.parse('${Config.baseUrl}pastoraisapi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar pastorais');
    }
  }
}
