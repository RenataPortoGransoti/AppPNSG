import 'package:flutter/material.dart';
import '../email.dart';
import 'dizimo.dart';
import 'doacao.dart';
import 'formulario_dizimista.dart';
import 'informacoes_dizimo.dart';
import 'navigation_bar.dart';
import 'inicio.dart';
import 'pastorais.dart';
import 'eventos.dart';
import 'informacoes.dart';


class Contribua extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContribuaState();
  }
}

class ContribuaState extends State<Contribua> {
  int currentPageIndex = 3;

  void _mostrarFormularioDizimista(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FormularioDizimista(
        onSubmit: (nomeCompleto, email, celular, nomeConjuge, endereco, numero, apto, bairro, cep, estadoCivil, dataNascimento, dataNascimentoConjuge) {
          sendEmail(
            nomeCompleto,
            celular,
            email,
            nomeConjuge,
            endereco,
            numero,
            apto,
            bairro,
            cep,
            estadoCivil,
            dataNascimento,
            dataNascimentoConjuge,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Formulário enviado com sucesso. Deus abençoe. Aguarde nosso contato!'),
              backgroundColor: Colors.lightGreen[800],
              duration: Duration(seconds: 4),
            ),
          );        },
        baseUrl: '',
      ),
    );
  }

  Future<void> sendEmail(
      String nomeCompleto,
      String celular,
      String email,
      String nomeConjuge,
      String endereco,
      String numero,
      String apto,
      String bairro,
      String cep,
      String estadoCivil,
      String dataNascimento,
      String dataNascimentoConjuge,
      ) async {
    final emailService = EmailService();

    String emailBody = '''
      Nome Completo: $nomeCompleto
      Celular: $celular
      Email: $email
      Nome do Cônjuge: $nomeConjuge
      Endereço: $endereco
      Número: $numero
      Apto: $apto
      Bairro: $bairro
      CEP: $cep
      Estado Civil: $estadoCivil
      Data de Nascimento: $dataNascimento
      Data de Nascimento do Cônjuge: $dataNascimentoConjuge
    ''';

    await emailService.sendEmail(
      fromEmail: 'renata.gransoti@edu.unifil.br',
      fromName: 'Aplicativo',
      subject: 'Novo formulário de dizimista preenchido - App PNSG!',
      body: emailBody,
    );
  }

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
            }
            else if (currentPageIndex == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Informacoes())
              );
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(
          padding: EdgeInsets.all(25),
          child:
            Text(
                  "Dê cada um conforme o impulso do seu coração, sem tristeza nem constrangimento. Deus ama o que dá com alegria - II Coríntios 9, 7",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
          ),
            SizedBox(height: 10),
            Text(
              "Formas de Contribuir",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dizimo()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(18),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Dízimo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Doacao()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(18),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Doação",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _mostrarFormularioDizimista(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Color(0xFF036896),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Ser Dizimista",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.9; // 50% da largura da tela
                return Image.asset(
                  'assets/images/donation.png',
                  width: imageSize,
                );
              },
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformacoesDizimo()),
                );
              },
              child: Text(
                'Saber mais sobre o Dízimo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 2.0, color: Color(0xFF036896)),
              ),
                ),
              ]),
            ),
    );
  }
}