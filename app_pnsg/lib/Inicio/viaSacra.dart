import 'package:flutter/material.dart';


class ViaSacra extends StatefulWidget {
  @override
  _ViaSacraState createState() => _ViaSacraState();
}

class _ViaSacraState extends State<ViaSacra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Via Sacra'),
      ),
      body: ViaSacraPartes(),
    );
  }
}

class ViaSacraPartes extends StatelessWidget {
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
    //I estação
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
        'Enquanto levavam Jesus para ser crucificado, Simão de Cirene, que voltava do campo, foi obrigado a carregar a cruz para que Jesus não desfalecesse pelo caminho, pois tinha de permanecer vivo até a crucifixão.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',
    //VI estação
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
    //XI estação
    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Jesus é crucificado. São cravados pregos de ferro que lhe rasgam a carne, dilacerando mãos e pés. A cruz é erguida, Jesus fica suspenso entre o céu e a terra. Agora é o fim, ele está definitivamente condenado.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Depois de longa agonia, Jesus lança seu último grito do alto da cruz: “Pai, em tuas mãos entrego o meu espírito”. Em seguida, inclinou a cabeça e entregou o espírito a Deus.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Às vésperas do sábado, José de Arimateia foi a Pilatos e pediu o corpo de Jesus. Com a permissão de Pilatos, José comprou um lençol de linho, desceu o corpo da cruz e o enrolou no lençol. Maria, sua mãe, recebeu-o em seus braços.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

    'V. Nós Vos adoramos e Vos bendizemos, Senhor Jesus\n'
        'R. Porque pela Vossa santa cruz remistes o mundo.\n\n'
        'Depois de envolvê-lo num lençol, José de Arimateia colocou o corpo de Jesus num túmulo escavado na rocha, onde ninguém ainda tinha sido sepultado, e rolou uma grande pedra para fechar a entrada do túmulo.\n'
        'Pai Nosso, Ave Maria, Glória\n'
        'Ó santa Mãe da dor, gravai no meu coração as chagas do Salvador.',

  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
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
    );

  }
}
