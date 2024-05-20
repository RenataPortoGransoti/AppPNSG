import 'package:app_pnsg/Screens/pastoraisScreen.dart';
import 'package:flutter/material.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

class Contribua extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ContribuaState();
  }
}

class ContribuaState extends State<Contribua> {
  int currentPageIndex = 3;

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
          }else if (currentPageIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PastoraisScreen()),
            );
          }else if(currentPageIndex == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Eventos()),
            );
          }else if(currentPageIndex == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contribua()),
            );
          }else if(currentPageIndex == 4){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Informacoes())
            );
          }
        });
      },
          selectedIndex: currentPageIndex,
          backgroundColor: Colors.lightBlue,
        ),

        body: Center(
        ));
  }}