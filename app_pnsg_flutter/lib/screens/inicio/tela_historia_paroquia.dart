import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../views/widgets/header_widget.dart';
import '../tela_contribua.dart';
import '../tela_eventos.dart';
import '../tela_informacoes.dart';
import '../tela_inicio.dart';
import '../navigation_bar.dart';
import '../tela_pastorais.dart';

class HistoriaParoquia extends StatefulWidget {
  const HistoriaParoquia({super.key});

  @override
  HistoriaParoquiaState createState() => HistoriaParoquiaState();
}

class HistoriaParoquiaState extends State<HistoriaParoquia> {
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
                MaterialPageRoute(builder: (context) => const Inicio()),
              );
            } else if (currentPageIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PastoraisScreen()),
              );
            } else if (currentPageIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Eventos()),
              );
            } else if (currentPageIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contribua()),
              );
            } else if (currentPageIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Informacoes()),
              );
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: const SingleChildScrollView(
      child: Column(
        children: [
          Historia(),
        ],
      ),
      ),
    );
  }
}

class Historia extends StatelessWidget {
  const Historia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderWidget(title: "História da Paróquia"),          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'A paróquia Nossa Senhora das Graças foi criada em 1º de novembro de 1955 e instalada oficialmente em 7 de outubro de 1956, sob a liderança do Padre Luiz Schweiger. Desde sua fundação, enfrentou diversos desafios, incluindo a necessidade de construir uma nova matriz, já que a primeira era uma simples capela de madeira que também funcionava como escola.\n\n'
                  'Com o tempo, a paróquia se desenvolveu significativamente. Em 1960, a pedra fundamental da nova igreja foi lançada, e em 21 de abril de 1961, a matriz foi transferida para seu local atual. Ao longo dos anos, a comunidade paroquial cresceu, e várias construções foram realizadas, incluindo o salão paroquial e a nova igreja, inaugurada parcialmente em 1979.\n\n'
                  'Durante os anos, a paróquia foi administrada por frades franciscanos que contribuíram para o crescimento espiritual e estrutural da comunidade. Em 1992, a administração passou para os padres diocesanos, marcando o fim da missão franciscana após 35 anos de dedicação.\n\n'
                  'No dia 27 de novembro de 2005, o templo foi restaurado e solenemente dedicado a Deus, em honra de Nossa Senhora das Graças, por sua excelência Dom Albano Cavallin.\n\n'
                  'Hoje, a Paróquia Nossa Senhora das Graças continua sendo um importante centro de fé e comunidade em Londrina, mantendo viva a história de superação e fé de seus fiéis.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 20.0),
          CarouselSlider(
            options: CarouselOptions(
              height: 280.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: [
              'assets/images/paroquia1.jpeg',
              'assets/images/paroquia2.jpeg',
              'assets/images/paroquia3.jpeg',
              'assets/images/paroquia4.jpeg',
              'assets/images/paroquia5.jpeg',
              'assets/images/paroquia6.jpeg',
              'assets/images/paroquia7.jpeg',
              'assets/images/paroquia8.jpeg',
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}