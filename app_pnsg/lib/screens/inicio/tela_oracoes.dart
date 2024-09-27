import 'package:flutter/material.dart';
import '../Screens/tela_contribua.dart';
import '../Screens/tela_eventos.dart';
import '../Screens/tela_informacoes.dart';
import '../Screens/tela_inicio.dart';
import '../Screens/navigation_bar.dart';
import '../Screens/tela_pastorais.dart';
import 'Oracoes/ave_maria.dart';
import 'Oracoes/credo.dart';
import 'Oracoes/magnificat.dart';
import 'Oracoes/pai_nosso.dart';
import 'Oracoes/rosario.dart';
import 'Oracoes/salve_rainha.dart';
import 'Oracoes/santo_anjo.dart';
import 'Oracoes/terco_divina_misericordia.dart';
import 'Oracoes/vinde_espirito_santo.dart';


class Oracoes extends StatefulWidget {
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
      body: Stack(
        children: [
          OracoesList(),
        ],
      ),
    );
  }
}

const String nome = 'Orações';

class OracoesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF036896).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
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

  OracoesTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5), // Espaço entre os itens
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
