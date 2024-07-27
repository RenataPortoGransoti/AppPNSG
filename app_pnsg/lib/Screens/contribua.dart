import 'package:app_pnsg/Screens/pastoraisScreen.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'eventos.dart';
import 'formulario_dizimista.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

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
          sendEmail(nomeCompleto, email, celular, nomeConjuge, endereco, numero, apto, bairro, cep, estadoCivil, dataNascimento, dataNascimentoConjuge);
        },
        baseUrl: '',
      ),
    );
  }

  Future<void> sendEmail(
      String nomeCompleto,
      String email,
      String celular,
      String nomeConjuge,
      String endereco,
      String numero,
      String apto,
      String bairro,
      String cep,
      String estadoCivil,
      String dataNascimento,
      String dataNascimentoConjuge
      ) async {
    final smtpServer = gmail('renata.porto.gransoti@gmail.com', 'ahpgpdyusnznyoif');
    final message = Message()
      ..from = Address('renata.gransoti@edu.unifil.br', 'Aplicativo')
      ..recipients.add('renatagransoti@gmail.com')
      ..subject = 'Novo mensagem enviada pelo aplicativo!'
      ..text = '''
      Nome Completo: $nomeCompleto
      Email: $email
      Celular: $celular
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

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
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
        child:
        GestureDetector(
          onTap: () {
            _mostrarFormularioDizimista(context);
          },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "Ser Dizimista",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      ),
    );
  }
}
