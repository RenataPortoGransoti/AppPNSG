import 'package:flutter/material.dart';
import 'package:app_pnsg/Screens/pastoraisScreen.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

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
          if (currentPageIndex == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inicio()),
            );
          }
          if (currentPageIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PastoraisScreen()),
            );
          }
          else if (currentPageIndex == 2) {
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

        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
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
                height: 200,
              ),


          ],
        ),
      ),
    );
  }

  String _buildImageUrl(String imagem) {
    return 'http://192.168.1.5:8000/storage/$imagem';
  }
}

