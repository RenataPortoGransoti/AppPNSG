import 'package:flutter/material.dart';

import 'navigation_bar.dart';

class InformacoesDizimo extends StatefulWidget {
  const InformacoesDizimo({super.key});

  @override
  State<StatefulWidget> createState() {
    return InformacoesDizimoState();
  }
}

class InformacoesDizimoState extends State<InformacoesDizimo> {
  int currentPageIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            switch (currentPageIndex) {
              case 0:
                Navigator.pushNamed(context, '/Inicio');
                break;
              case 1:
                Navigator.pushNamed(context, '/PastoraisScreen');
                break;
              case 2:
                Navigator.pushNamed(context, '/Eventos');
                break;
              case 3:
                Navigator.pushNamed(context, '/Contribua');
                break;
              case 4:
                Navigator.pushNamed(context, '/Informacoes');
                break;
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
       body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF036896).withOpacity(0.8),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Sobre o Dízimo",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            buildQuestionAnswer(
                'O que é o dízimo?',
                "Dízimo é um ato de gratidão a Deus, do qual recebemos tudo o que temos. É devolução a Ele de um pouco do que d'Ele recebemos, por meio da Igreja, para que o seu Reino aconteça entre nós. É manifestação de nosso amor a Deus e aos irmãos. É partilha dos bens que estão ao nosso dispor, especialmente com os mais necessitados.",
                Colors.lightBlue.shade50,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'Todos devem contribuir com o dízimo?',
                'Sim! O oferecimento do Dízimo nasce do coração de cada cristão participante em sua comunidade. O cristão esclarecido, em espírito de oração, fará a Deus a sua promessa, o seu voto de ofertar o Dízimo. É um ato de amor a Deus e aos irmãos.',
                Colors.white,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'Quanto se deve dar de Dízimo?',
                'Dízimo é uma questão de generosidade. "Dê cada um conforme o impulso do seu coração, sem tristeza nem constrangimento. Deus ama quem dá com alegria."(1 Cor. 9,7). O dizimista deve sentir-se livre perante Deus ao fixar o percentual de sua contribuição. Não deve se preocupar com o que sai do seu bolso (se muito ou pouco dinheiro), mas com o que sai de seu coração (se pouco ou muito amor a Deus e a Comunidade.',
                Colors.lightBlue.shade50,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'O dízimo deve ser mensal?',
                'Sim. O dízimo deve ser levado à comunidade, mensalmente, pois os ganhos do dizimista são mensais e as necessidades da comunidade também.',
                Colors.white,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'Onde é aplicado o dízimo?',
                'É bom saber que o Dízimo tem destino certo: nas despesas com a Santa Missa (toalhas, velas, flores, luz, água, vinho, hóstias...). Com o templo, energia, som de qualidade, bancos, limpeza. Despesas com as pastorais (catequeses, retiros, livros, cartazes). Remuneração dos funcionários, manutenção dos bens da paróquia, secretaria paroquial). Promoção humana e social, (pobres, idosos, crianças, dependentes químicos). Colaboração com as comunidades mais necessitadas, missões. Formação de lideranças (formação dos futuros padres, misnitstros, catequistas).',
                Colors.lightBlue.shade50,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'O dízimo é expressão da caridade',
                'O Dízimo, dado com amor, faz-nos mais generosos e agrada a Deus. Faz-nos mais desapegados dos bens terrenos; abre nosso coração no amor ao próximo. É um caminho de conversão. Faz-nos mais desapegados dos bens terrenos; abre nosso coração no amor ao próximo. É um caminho de conversão. Faz-nos lembrar, todo mês, do Autor da Vida, do Criador do Universo. Deus, que prometeu que não ficaria sem recompensa um só copo de água fresca, dado a um pequenino (Mt 10,42), não se deixará vencer em generosidade para conosco. Só é dizimista de verdade quem acredita na Palavra de Deus.',
                Colors.white,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'Quais os efeitos produzidos pela partilha do Dízimo?',
                'Com certeza, com a oferta do Dízimo haverá um maior entendimento da Palavra d Deus. Uma descoberta de que o Dízimo é um ato de louvor, um compromisso com Deus, com a Igreja e com os pobres. Crescerá a alegria do coração e as bençãos de Deus virão com certeza sobr eo dizimista. O dizimista participa de toda a ação evangelizadora que a Igreja realiza.',
                Colors.lightBlue.shade50,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'O dízimo está na Bíblia?',
                "Sim, o Dízimo é Bíblico. São muitos os textos onde se percebe que o Dízimo é uma recomendação bíblica. Confira algumas citações do Antigo e do Novo Testamento: Gn 14,20; Ml 3,10; Lv 27,32; Gn 28,22; Ex 22,28; 2 Cor 9, 6-12; At 4,32; Mt 23,23.",
                Colors.white,
                Colors.black
            ),
            const SizedBox(height: 20),
            buildQuestionAnswer(
                'Dízimo e suas dimensões',
                "Primeira dimensão do dízimo é a religiosa. A partir de uma experiência, de descobrir-se amado por Deus, é que o fiel quer em gesto concreto colaborar com sua vida e com os seus bens que também outros façam a mesma experiência de saber ser amado por Deus."
                    " Devolvendo uma parte dos seus bens, o fiel cultiva e aprofunda sua relação com aquele de quem provém tudo o que ele é e tudo o que ele tem, e expressa, na gratidão, sua fé e sua conversão. Dízimo é evangelização, por meio de nossa doação gratuita, ajudamos que a mensagem do Evangelho chegue a muitos lugares.\n\n"
                "O dízimo também tem sua dimensão eclesial. Com o dízimo, o fiel vivencia sua consciência de ser membro da Igreja, pela qual é corresponsável, contribuindo para que a comunidade disponha do necessário para realizar o culto divino e para desenvolver sua missão\n\n"
                "Na dimensão missionário, o dízimo permite a partilha de recursos entre as paróquias, comunidades mais pobres, manifestando a comunhão que há entre elas. Nosso dízimo contribui para que a Palavra de Deus chegue a cantos longíquos.\n\n"
                    "O dízimo tem ainda a dimensão caritativa, que se manifesta no cuidado com os pobres, por parte da comunidade, por meio de um acompanhamento sério e de promoção da pessoa.",
                Colors.lightBlue.shade50,
                Colors.black
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionAnswer(String question, String answer, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Color(0xFF036896),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
