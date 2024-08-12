import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../config.dart';
import '../contatoFormulario.dart';
import 'contribua.dart';
import 'eventos.dart';
import 'inicio.dart';
import 'navigation_bar.dart';
import 'pastoraisScreen.dart';
import '../email.dart';
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
  };
  String phoneNumber = "";
  String instagramUrl = "";
  String facebookUrl = "";
  String instagramUsername = "";

  @override
  void initState() {
    super.initState();
    fetchHorarios(); // Chama a função para buscar os horários ao iniciar a tela
    fetchContactDetails();  }

  // Função para buscar os horários da API Laravel
  void fetchHorarios() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}horariosapi'));

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

// Função para buscar os detalhes de contato da API Laravel
  void fetchContactDetails() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}contatosapi'));

      if (response.statusCode == 200) {
        setState(() {
          var parsedJson = json.decode(response.body) as Map<String, dynamic>;
          phoneNumber = parsedJson['contato'][0]['valor']; // Atualiza o número de telefone
          instagramUrl = parsedJson['instagram'][0]['valor']; // Atualiza o URL do Instagram
          facebookUrl = parsedJson['facebook'][0]['valor']; // Atualiza o URL do Facebook
          // Extrair o nome de usuário do URL do Instagram
          if (instagramUrl.isNotEmpty) {
            final uri = Uri.parse(instagramUrl);
            instagramUsername = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
          }
        });
      } else {
        throw Exception('Falha ao carregar os detalhes de contato');
      }
    } catch (e) {
      print('Erro ao carregar os detalhes de contato: $e');
    }
  }

  void _launchPhone() async {
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

  // Função para abrir o Instagram
  void _abrirInstagram() async {
    var nativeUrl = instagramUrl.replaceFirst('https://www.instagram.com/', 'instagram://user?username=');
    var webUrl = instagramUrl;

    try {
      if (await canLaunch(nativeUrl)) {
        await launch(nativeUrl);
      } else {
        await launch(webUrl);
      }
    } catch (e) {
      print(e);
      await launch(webUrl);
    }
  }

  // Função para abrir o Facebook
  void _abrirFacebook() async {
    var nativeUrl = facebookUrl.replaceFirst('https://www.facebook.com/', 'fb://page/');
    var webUrl = facebookUrl;

    try {
      if (await canLaunch(nativeUrl)) {
        await launch(nativeUrl);
      } else {
        await launch(webUrl);
      }
    } catch (e) {
      print(e);
      await launch(webUrl);
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
          // Chama a função para enviar email da classe InformacoesState
          sendEmail(nomeCompleto, email, celular, mensagem);
          Navigator.pop(context); // Fecha o diálogo do formulário após envio
        }, baseUrl: '',
      ),
    );
  }

  String _text = '';
  var email = Email('renata.porto.gransoti@gmail.com', 'ahpgpdyusnznyoif');

  void sendEmail(String nomeCompleto, String email, String celular, String mensagem) async {
    var emailService = Email('renata.porto.gransoti@gmail.com', 'ahpgpdyusnznyoif');
    bool result = await emailService.sendMessage(
      mensagem,
      email,
      nomeCompleto,
      'Novo mensagem enviada pelo aplicativo!',
      nomeCompleto: nomeCompleto,
      celular: celular,
    );
    setState(() {
      _text = result ? 'Enviado.' : 'Não enviado.';
    });
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
              Text('Entre em contato:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
              GestureDetector(
                onTap: () {
                  _launchPhone();
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
                    "$phoneNumber - Ligar agora",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  abrirWhatsapp('$phoneNumber', 'Olá!');
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
              Text('Nos acompanhe nas redes sociais:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, )),
              SizedBox(height: 20),
              //abrirInstagram();
          GestureDetector(
            onTap: () {
              _abrirInstagram();
            },child:
              Text('Instagram - @$instagramUsername',style: TextStyle(
                decoration: TextDecoration.underline, // Adicionando sublinhado
                decorationColor: Color(0xFF036896), // Cor do sublinhado
                decorationThickness: 1, // Espessura do sublinhado
              ),),

          ),
              SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              _abrirFacebook();
            },child:
              Text('Facebook - pnsgracalondrina',style: TextStyle(
                decoration: TextDecoration.underline, // Adicionando sublinhado
                decorationColor: Color(0xFF036896), // Cor do sublinhado
                decorationThickness: 1, // Espessura do sublinhado
              ),),
          ),
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
