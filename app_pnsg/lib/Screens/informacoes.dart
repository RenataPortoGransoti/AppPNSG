import 'package:app_pnsg/Screens/pastoraisScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../contatoFormulario.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

class Informacoes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InformacoesState();
  }
}

class InformacoesState extends State<Informacoes> {
  int currentPageIndex = 4;

  // Função para lançar o telefone
  void _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Não foi possível lançar $phoneNumber';
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
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text('Entre em contato:', ),
            GestureDetector(
              onTap: () {
                _launchPhone('43-3342-1276');
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
                  "(43) 3342-1276 - Ligar agora",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Iniciar conversa no WhatsApp",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ContactForm(
                    onSubmit: (fullName, email, phone, message) {
                      // Aqui você pode fazer algo com os dados do formulário, se necessário
                      print('Nome: $fullName, E-mail: $email, Celular: $phone, Mensagem: $message');
                    },
                  ),
                );
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
                  "Enviar Mensagem",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Nos acompanhe nas redes sociais:'),
            SizedBox(height: 20),
            Text('Instagram - @pnsgracalondrina'),
            SizedBox(height: 15),
            Text('Facebook - pnsgracalondrina'),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color(0xFF036896),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Horário Secretaria Paroquial",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color(0xFF036896),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Horário Missa",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color(0xFF036896),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Horário Confissões",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Image
              (image: AssetImage('assets/images/mapa_paroquia.png')
            ),

          ],
        ),
      ),
      ),
    );
  }
}
