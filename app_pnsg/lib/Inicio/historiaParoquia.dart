import 'package:flutter/material.dart';

import '../Screens/contribua.dart';
import '../Screens/eventos.dart';
import '../Screens/informacoes.dart';
import '../Screens/inicio.dart';
import '../Screens/navigation_bar.dart';
import '../Screens/pastoraisScreen.dart';

class HistoriaParoquia extends StatefulWidget {
  @override
  _HistoriaParoquiaState createState() => _HistoriaParoquiaState();
}

class _HistoriaParoquiaState extends State<HistoriaParoquia> {
  int currentPageIndex = 0;

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
      body: Column(
        children: [
          Historia(),
        ],
      ),
    );
  }
}

const String nome = 'História da Paróquia';

class Historia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF036896).withOpacity(0.8),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        nome,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
      ],
    );
  }
}