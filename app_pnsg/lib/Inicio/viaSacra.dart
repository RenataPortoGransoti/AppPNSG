import 'package:flutter/material.dart';

class ViaSacra extends StatefulWidget {
  @override
  _ViaSacraState createState() => _ViaSacraState();
}

class _ViaSacraState extends State<ViaSacra> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> titulos = [
    'I ESTAÇÃO \n JESUS É CONDENADO À MORTE',
    'II ESTAÇÃO \n JESUS CARREGA A CRUZ',
    'III ESTAÇÃO \n JESUS CAI PELA PRIMEIRA VEZ',
    'IV ESTAÇÃO \n JESUS ENCONTRA MARIA, SUA MÃE',
    'V ESTAÇÃO \n CIRINEU AJUDA JESUS A LEVAR A SUA CRUZ',
    'VI ESTAÇÃO \n VERÔNICA LIMPA O ROSTO DE JESUS',
    'VII ESTAÇÃO \n JESUS CAI PELA SEGUNDA VEZ',
    'VIII ESTAÇÃO \n JESUS ENCONTRA AS MULHERES',
    'IX ESTAÇÃO \n JESUS CAI PELA TERCEIRA VEZ',
    'X ESTAÇÃO \n JESUS É DESPOJADO DE SUAS VESTES',
    'XI ESTAÇÃO \n JESUS É PREGADO NA CRUZ',
    'XII ESTAÇÃO \n JESUS MORRE NA CRUZ',
    'XIII ESTAÇÃO \n JESUS É DESCIDO DA CRUZ',
    'XIV ESTAÇÃO \n JESUS É DEPOSITADO NO SEPULCRO',
  ];

  final List<String> textos = [
    // Textos de cada estação da Via Sacra
    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Quando o “povo” pediu a crucificação de Jesus, Pilatos pediu água e lavou as mãos, dizendo: “Não sou responsável pelo sangue deste homem. É um problema de vocês”. Depois de mandar açoitar Jesus, entregou-o para ser crucificado. '
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus recebe sobre seus ombros a cruz e se dirige ao monte Calvário ou Gólgota, onde será crucificado. A cruz era um antigo instrumento de suplício, usado para executar os condenados à morte.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus caminha cansado e abatido sob o peso da cruz. Seu corpo está coberto de sangue, suas forças esmorecem, e ele cai. Com chicotes,os soldados o forçam a se levantar e continuar o caminho para o Calvário.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Mãe e filho se encontram e se abraçam em meio à dor. Eles tudo partilham, até a cruz, até o fim. Sem palavras, a dor leva-nos a compartilhar este momento sofrido, expresso em seus rostos.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Enquanto levavam Jesus para ser crucificado, Simão de Cirene, que voltava do campo, foi obrigado a carregar a cruz para que Jesus não desfalecesse pelo caminho, pois tinha de permanecer vivo até a crucificação.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Uma mulher que assistia à passagem de Jesus se comove ao ver a cena e decide limpar a face do condenado tingida de sangue. No pano usado por Verônica ficou gravado o rosto de Jesus.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus sabia do fim que o esperava. Seu espírito estava preparado, mas seu corpo estava esgotado e abatido. Por isso, caminhava com dificuldade e pela segunda vez cai sob a cruz.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Já estavam próximos do monte Calvário. Jesus, abatido pela dor e vendo suas forças esgotadas, ainda tem ânimo para consolar as mulheres que, chorando, lamentavam o sofrimento dele.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus já não suporta o cansaço e a dor, por isso cai pela terceira vez sob o peso da cruz. Quiseram dar-lhe vinho misturado com fel para aliviar a dor, mas ele não quis beber.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Os soldados tomaram as roupas de Jesus e fizeram um sorteio, para ver a parte que cabia a cada um. Assim se cumpre a profecia: “Repartiram entre si minhas vestes e lançaram sorte sobre a minha túnica”.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus é crucificado. São cravados pregos de ferro que lhe rasgam a carne, dilacerando mãos e pés. A cruz é erguida, Jesus fica suspenso entre o céu e a terra. Agora é o fim, ele está definitivamente condenado.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus morre na cruz. Ele está entregando a alma, consumando a obra da redenção. Tudo está cumprido, o véu do templo se rasga, a terra treme e os corações se comovem. É o grito de dor de um Deus que se faz homem, que morre por amor.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus é descido da cruz. Seu corpo é levado nos braços de Maria, que o recebe da mesma forma que o entregou, com amor e ternura. É o fim de uma vida, é o fim de uma história. Jesus se entrega ao Pai.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus é colocado no sepulcro. É o repouso de um corpo dilacerado pela dor. Agora ele está morto, é o fim de uma história, mas o início de uma nova vida. Jesus ressuscitou, ele está vivo no meio de nós.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Via Sacra'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: titulos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        titulos[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF036896),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        textos[index],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (_currentPage > 0)
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                _buildPageIndicator(),
                if (_currentPage < titulos.length - 1)
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(titulos.length, (int index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Color(0xFF036896) : Colors.grey,
          ),
        );
      }),
    );
  }
}

void main() => runApp(MaterialApp(
  home: ViaSacra(),
));
