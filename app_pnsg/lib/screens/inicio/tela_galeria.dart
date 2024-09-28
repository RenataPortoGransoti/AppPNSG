import 'package:flutter/material.dart';
import '../tela_contribua.dart';
import '../tela_eventos.dart';
import '../tela_informacoes.dart';
import '../tela_inicio.dart';
import '../navigation_bar.dart';
import '../tela_pastorais.dart';

class Galeria extends StatefulWidget {
  const Galeria({super.key});

  @override
  GaleriaState createState() => GaleriaState();
}

class GaleriaState extends State<Galeria> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

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
                MaterialPageRoute(builder: (context) => const Inicio()),
              );
            } else if (currentPageIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PastoraisScreen()),
              );
            } else if (currentPageIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Eventos()),
              );
            } else if (currentPageIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contribua()),
              );
            } else if (currentPageIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Informacoes()),
              );
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: const Column(
        children: [
          Expanded(child: GaleriaPagina()), // Ocupa o espaço restante
        ],
      ),
    );
  }
}

const String nome = 'Galeria';

class GaleriaPagina extends StatelessWidget {
  final String googleDriveFolderUrl =
      'https://drive.google.com/drive/folders/YOUR_FOLDER_ID?usp=sharing';

  const GaleriaPagina({super.key}); // Substitua pelo link da sua pasta

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF036896).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
            nome,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
]
        );

  }
}
