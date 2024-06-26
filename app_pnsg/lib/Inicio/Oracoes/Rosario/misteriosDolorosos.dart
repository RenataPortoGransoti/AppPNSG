import 'package:flutter/material.dart';

class MisteriosDolorosos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistérios Dolorosos'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text('1º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Agonia de Jesus no horto das oliveiras.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('2º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Flagelação de Nosso Senhor Jesus Cristo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('3º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A coroação de espinhos de Nosso Senhor Jesus Cristo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('4º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Nosso Senhor carregando a Cruz nas costas a caminho do Calvário.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('5º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Crucifixão e morte de Nosso Senhor Jesus Cristo.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
