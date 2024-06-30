import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../contatoFormulario.dart';
import '../email_service.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'inicio.dart';
import 'navigation_bar.dart';
import 'pastoraisScreen.dart'; // Suponho que você tenha importado corretamente a tela PastoraisScreen
class Informacoes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InformacoesState();
  }
}

class InformacoesState extends State<Informacoes> {
  int currentPageIndex = 4;
  Map<String, List<dynamic>> horarios = {
    'secretaria': [],
    'missa': [],
    'confissao': [],
  }; // Mapa para armazenar os horários por tipo

  @override
  void initState() {
    super.initState();
    fetchHorarios(); // Chama a função para buscar os horários ao iniciar a tela
  }

  // Função para buscar os horários da API Laravel
  void fetchHorarios() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.5:8000/horariosapi'));

      if (response.statusCode == 200) {
        setState(() {
          var parsedJson = json.decode(response.body) as Map<String, dynamic>;
          // Iterar sobre as chaves do JSON para preencher horarios corretamente
          parsedJson.forEach((key, value) {
            if (key == 'secretaria' || key == 'missa' || key == 'confissao') {
              horarios[key] = value as List<dynamic>;
            }
          });
        });
      } else {
        throw Exception('Falha ao carregar os horários');
      }
    } catch (e) {
      print('Erro ao carregar os horários: $e');
    }
  }

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





//abrir instagram
  void abrirInstagram() async {
    var messengerUrl = 'https://instagram.com/pnsgracalondrina';
    if (await canLaunchUrl(Uri.parse(messengerUrl))) {
      await launchUrl(Uri.parse(messengerUrl));
    } else {
      throw 'Could not launch $messengerUrl';
    }
  }

// Função para lançar o WhatsApp com o número específico
  void abrirWhatsapp(
      String phone,
      String message,
      ) async {
    final url = 'https://wa.me/55$phone?text=$message';

    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
  // Método para mostrar o diálogo de formulário de contato
  void _showContactFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContactForm(
        onSubmit: (nomeCompleto, email, celular, mensagem) {
          // Chama a função para enviar email
          sendEmail(nomeCompleto, email, celular, mensagem);
          Navigator.pop(context); // Fecha o diálogo do formulário após envio
        },
      ),
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
            } else if (currentPageIndex == 4) {
              // Não é necessário redirecionar para a própria página Informacoes
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Informacoes()),
              // );
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
              Text('Entre em contato:'),
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
              GestureDetector(
                onTap: () {
                  abrirWhatsapp('4333421276', 'Olá!'); // Chama o método para abrir o WhatsApp
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
                    "Iniciar conversa no WhatsApp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showContactFormDialog(context);
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
              //abrirInstagram();
              Text('Instagram - @pnsgracalondrina'),
              SizedBox(height: 15),
              Text('Facebook - pnsgracalondrina'),
              SizedBox(height: 30),

              // Containers de horários expandíveis
              Text(
                'HORÁRIOS:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildHorarioTile("Secretaria Paroquial", 'secretaria'), // Tipo 'secretaria'
              _buildHorarioTile("Missas", 'missa'), // Tipo 'missa'
              _buildHorarioTile("Confissões", 'confissao'), // Tipo 'confissao'

              SizedBox(height: 20),
              Image(image: AssetImage('assets/images/mapa_paroquia.png')),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir um ExpansionTile para os horários
  Widget _buildHorarioTile(String titulo, String tipo) {
    var horariosList = horarios[tipo];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Color(0xFF036896),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: ThemeData(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: ExpansionTile(
          shape: Border(),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              titulo,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          iconColor: Colors.white, // Cor do ícone de expandir/recolher
          children: [
            if (horariosList != null && horariosList.isNotEmpty)
              Column(
                children: horariosList.map<Widget>((horario) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Text(
                      horario['descricao'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            if (horariosList == null || horariosList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text(
                  'Não há horário cadastrado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
