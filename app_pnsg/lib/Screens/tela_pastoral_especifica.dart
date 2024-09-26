import 'package:flutter/material.dart';
import 'pastorais.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';
import '../config.dart';

class PastoralEspecifica extends StatelessWidget {
  final String nome;
  final String? descricao;
  final String? imagem;

  PastoralEspecifica({required this.nome, this.descricao, this.imagem});

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 1;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: (int index) {
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
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
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
                  nome,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (descricao != null)
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    descricao!,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              if (imagem != null && imagem!.isNotEmpty)
                Image.network(
                  _buildImageUrl(imagem!),
                  width: 200,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildImageUrl(String imagem) {
    return '${Config.baseUrl}storage/$imagem';
  }
}
