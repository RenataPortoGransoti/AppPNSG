import 'package:flutter/material.dart';

class MisteriosGloriosos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Misterios Gloriosos'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text('1º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Ressureição de Nosso Senhor Jesus Cristo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('2º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Ascensão de Nosso Senhor Jesus Cristo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('3º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A vinda do Espírito Santo a Nossa Senhora e os Apóstolos reunidos no Santo Cenáculo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('4º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Assunção de Nossa Senhora aos Céus de corpo e alma.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('5º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Coroação de Nossa Senhora como Rainha do Céu e da Terra dos Anjos e dos Homens.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
