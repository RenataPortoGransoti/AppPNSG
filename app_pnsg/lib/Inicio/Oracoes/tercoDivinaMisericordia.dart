import 'package:flutter/material.dart';

class TercoDivinaMisericordia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terço da Divina Misericórdia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhado à esquerda
          children: [
            Text(
              'Para rezar o Terço da Divina Misericórdia pode-se usar um terço normal. Seguir a sequência abaixo:',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify, // Justificado
            ),
            SizedBox(height: 10), // Espaçamento entre os textos
            Text('1. Sinal da Cruz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('2. Pai Nosso', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('3. Ave Maria', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('4. Credo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('5. Nas contas maiores do Terço, ao rezar o Pai Nosso reza-se:', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Eterno Pai, eu Vos ofereço o Corpo e Sangue, a Alma e Divindade de Vosso diletíssimo Filho, Nosso Senhor Jesus Cristo, em expiação dos nossos pecados e do mundo inteiro.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('6. Nas contas menores do Terço, ao rezar a Ave Maria, reza-se:', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Pela Sua dolorosa Paixão, tende misericórdia de nós e do mundo inteiro.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('7. Invocação. No final do terço, reza-se por três vezes:', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Deus Santo, Deus Forte, Deus Imortal, tende piedade de nós e do mundo inteiro.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('8. Oração conclusiva (opcional)', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
            SizedBox(height: 10),
            Text('Deus, Pai Misericordioso, que revelou Teu amor em Teu Filho Jesus Cristo, e o derramou sobre nós no Espírito Santo, confiamos-Te hoje o destino do mundo e de cada homem. Dobre-se sobre nós pecadores, cure nossa fraqueza, vença todo o mal, deixe que todos os habitantes da Terra experimentem a Tua misericórdia, para que em Ti, o Deus Trino, possam sempre encontrar a fonte da esperança. Pai Eterno, pela dolorosa Paixão e Ressurreição de Teu Filho, tende piedade de nós e do mundo inteiro. Amém.', style: TextStyle(fontSize: 18), textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}