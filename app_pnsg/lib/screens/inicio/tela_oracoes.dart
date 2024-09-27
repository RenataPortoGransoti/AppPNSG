import 'package:flutter/material.dart';
import '../tela_contribua.dart';
import '../tela_eventos.dart';
import '../tela_informacoes.dart';
import '../tela_inicio.dart';
import '../navigation_bar.dart';
import '../tela_pastorais.dart';
import 'oracoes/ave_maria.dart';
import 'oracoes/credo.dart';
import 'oracoes/magnificat.dart';
import 'oracoes/pai_nosso.dart';
import 'oracoes/rosario.dart';
import 'oracoes/salve_rainha.dart';
import 'oracoes/santo_anjo.dart';
import 'oracoes/terco_divina_misericordia.dart';
import 'oracoes/vinde_espirito_santo.dart';


class Oracoes extends StatefulWidget {
  const Oracoes({super.key});

  @override
  _OracoesState createState() => _OracoesState();
}

class _OracoesState extends State<Oracoes> {
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
      body: const Stack(
        children: [
          OracoesList(),
        ],
      ),
    );
  }
}

const String nome = 'Orações';

class OracoesList extends StatelessWidget {
  const OracoesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF036896).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
            nome,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              OracoesTile(
                title: 'Ave Maria',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AveMaria()),
                  );
                },
              ),
              OracoesTile(
                title: 'Credo',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Credo()),
                  );
                },
              ),
              OracoesTile(
                title: 'Magnificat',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Magnificat()),
                  );
                },
              ),
              OracoesTile(
                title: 'Pai Nosso',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaiNosso()),
                  );
                },
              ),
              OracoesTile(
                title: 'Rosário',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Rosario()),
                  );
                },
              ),
              OracoesTile(
                title: 'Salve Rainha',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalveRainha()),
                  );
                },
              ),
              OracoesTile(
                title: 'Santo Anjo',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SantoAnjo()),
                  );
                },
              ),
              OracoesTile(
                title: 'Terço da Divina Misericórdia',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TercoDivinaMisericordia()),
                  );
                },
              ),
              OracoesTile(
                title: 'Vinde Espírito Santo',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VindeEspiritoSanto()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OracoesTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OracoesTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
