import 'package:flutter/material.dart';

class Magnificat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magnificat'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Minha alma glorifica ao Senhor, meu espírito; exulta de alegria em Deus, meu Salvador, porque olhou para sua pobre serva. Por isto, desde agora, me proclamarão bem-aventurada todas as gerações, porque realizou em mim maravilhas aquele que é poderoso e cujo nome é Santo. Sua misericórdia se estende, de geração em geração, sobre os que o temem. Manifestou o poder do seu braço: desconcertou os corações dos soberbos. Derrubou do trono os poderosos e exaltou os humildes. Saciou de bens os indigentes e despediu de mãos vazias os ricos. Acolheu a Israel, seu servo, lembrado da sua misericórdia, conforme prometera a nossos pais, em favor de Abraão e sua posteridade, para sempre.      (Lc 1, 46b - 55)',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
