import 'package:flutter/material.dart';

class MisteriosGozosos extends StatelessWidget {
  const MisteriosGozosos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistérios Gozosos'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('1º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Anunciação do Anjo e a Encarnação do Verbo no seio Puríssimo de Maria.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('2º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A visitação de Maria a sua prima Santa Isabel.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('3º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Nascimento do Menino Jesus, na gruta fria em Belém.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('4º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A apresentação do Menino Jesus, na gruta fria em Belém.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('5º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A perda e o encontro do Menino Jesus no templo discutindo com os doutores da Lei.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
