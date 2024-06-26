import 'package:flutter/material.dart';
import 'Rosario/misteriosDolorosos.dart';
import 'Rosario/misteriosGloriosos.dart';
import 'Rosario/misteriosGozosos.dart';
import 'Rosario/misteriosLuminosos.dart';


class Rosario extends StatefulWidget {
  @override
  _RosarioState createState() => _RosarioState();
}

class _RosarioState extends State<Rosario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rosário'),
      ),
      body: RosarioList(),
    );
  }
}

class RosarioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        SizedBox(height: 10),
        Text('Creio em Deus Pai...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        Text('Pai Nosso...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        Text('3 Ave Marias', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        Text('Glória', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        Text('Rezar os mistérios, a cada mistério rezar 1 Pai Nosso, 10 Ave Marias, Glória e Ó meu Jesus...', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        Text('Ao final, rezar:', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        Text('Salve Rainha...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        SizedBox(height: 15),
        Text('*Após cada Glória, rezar: ', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        Text(' Ó meu Jesus, perdoais-nos, livrai-nos do fogo do inferno, levai as almas todas para o céu e socorrei principalmente as que mais precisarem. Abençoai o Santo Padre o Papa Francisco, nosso arcebispo Dom Geremias, o Pe. (nome do Pároco) e todo clero e dai-nos a paz.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),

        RosarioTile(
          title: 'Mistérios Gozosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisteriosGozosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Luminosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisteriosLuminosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Dolorosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisteriosDolorosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Gloriosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisteriosGloriosos()),
            );
          },
        ),
      ],
    );
  }
}

class RosarioTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  RosarioTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
