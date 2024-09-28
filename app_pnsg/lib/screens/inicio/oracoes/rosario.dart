import 'package:PNSG/screens/inicio/oracoes/rosario/misterios_dolorosos.dart';
import 'package:PNSG/screens/inicio/oracoes/rosario/misterios_gloriosos.dart';
import 'package:PNSG/screens/inicio/oracoes/rosario/misterios_gozosos.dart';
import 'package:PNSG/screens/inicio/oracoes/rosario/misterios_luminosos.dart';
import 'package:flutter/material.dart';



class Rosario extends StatefulWidget {
  const Rosario({super.key});

  @override
  RosarioState createState() => RosarioState();
}

class RosarioState extends State<Rosario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rosário'),
      ),
      body: const RosarioList(),
    );
  }
}

class RosarioList extends StatelessWidget {
  const RosarioList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        const SizedBox(height: 10),
        const Text('Creio em Deus Pai...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        const Text('Pai Nosso...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        const Text('3 Ave Marias', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        const Text('Glória', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        const Text('Rezar os mistérios, a cada mistério rezar 1 Pai Nosso, 10 Ave Marias, Glória e Ó meu Jesus...', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        const Text('Ao final, rezar:', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        const Text('Salve Rainha...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),
        const SizedBox(height: 15),
        const Text('*Após cada Glória, rezar: ', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        const Text(' Ó meu Jesus, perdoais-nos, livrai-nos do fogo do inferno, levai as almas todas para o céu e socorrei principalmente as que mais precisarem. Abençoai o Santo Padre o Papa Francisco, nosso arcebispo Dom Geremias, o Pe. (nome do Pároco) e todo clero e dai-nos a paz.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), textAlign: TextAlign.justify),

        RosarioTile(
          title: 'Mistérios Gozosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MisteriosGozosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Luminosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MisteriosLuminosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Dolorosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MisteriosDolorosos()),
            );
          },
        ),
        RosarioTile(
          title: 'Mistérios Gloriosos',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MisteriosGloriosos()),
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

  const RosarioTile({super.key, required this.title, required this.onTap});

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
