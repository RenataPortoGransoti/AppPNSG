import 'package:flutter/material.dart';

class MisteriosLuminosos extends StatelessWidget {
  const MisteriosLuminosos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistérios Luminosos'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text('1º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Batismo de Nosso Senhir Jesus Cristo no rio Jordão.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('2º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Primeiro sinal de Nosso Senhor Jesus Cristo, transformando a água em binho nas bodas de Caná.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('3º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Anúncio do Reino de Deus e o convite à conversão.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('4º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A transfiguração de Nosso Senhor no Monte Tabor.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('5º Mistério', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('A Instituição da Eucaristia na Última Ceia e do Sacerdócio.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
