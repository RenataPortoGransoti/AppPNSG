import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config.dart';
import '../contato_formulario.dart';
import 'navigation_bar.dart';
import '../email.dart';
import '../logger.dart';

class Informacoes extends StatefulWidget {
  const Informacoes({super.key});

  @override
  State<StatefulWidget> createState() {
    return InformacoesState();
  }
}

class InformacoesState extends State<Informacoes> {

  int currentPageIndex = 4;
  Map<String, List<dynamic>> horarios = {
    'secretaria': [],
    'missa': [],
    'confissão': [],
  };
  String phoneNumber = "";
  String instagramUrl = "";
  String facebookUrl = "";
  String instagramUsername = "";
  @override
  void initState() {
    super.initState();
    fetchHorarios();
    fetchContactDetails();  }

  Future<void>  fetchHorarios() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}horariosapi'));

      if (response.statusCode == 200) {
        setState(() {
          var parsedJson = json.decode(response.body) as Map<String, dynamic>;
          // Iterar sobre as chaves do JSON para preencher horarios corretamente
          parsedJson.forEach((key, value) {
            if (key == 'secretaria' || key == 'missa' || key == 'confissão') {
              horarios[key] = value as List<dynamic>;
            }
          });
        });
      } else {
        throw Exception('Falha ao carregar os horários');
      }
    } catch (e) {
      logger.i('Erro ao carregar os horários: $e');
    }
  }

  Future<void>  fetchContactDetails() async {
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
      logger.i('Erro ao carregar os detalhes de contato: $e');
    }
  }

  void _launchPhone() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Não foi possível lançar $phoneNumber';
    }
  }

void _abrirInstagram() async {
  var nativeUrl = instagramUrl.replaceFirst('https://www.instagram.com/', 'instagram://user?username=');
  var webUrl = instagramUrl;

  try {
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      await launchUrl(Uri.parse(webUrl));
    }
  } catch (e) {
    logger.i(e);
    await launchUrl(Uri.parse(webUrl));
  }
}

void _abrirFacebook() async {
  var nativeUrl = facebookUrl.replaceFirst('https://www.facebook.com/', 'fb://page/');
  var webUrl = facebookUrl;

  try {
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      await launchUrl(Uri.parse(webUrl));
    }
  } catch (e) {
    logger.i(e);
    await launchUrl(Uri.parse(webUrl));
  }
}

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
  void _showContactFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContactForm(
        onSubmit: (nomeCompleto, email, celular, mensagem) {
          // Chama a função para enviar email usando o EmailService
          sendEmail(nomeCompleto, email, celular, mensagem);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Formulário enviado com sucesso. Aguarde nosso contato!'),
              backgroundColor: Colors.lightGreen[800],
              duration: const Duration(seconds: 4),
            ),
          );
        },
        baseUrl: '',
      ),
    );
  }

  Future<void> sendEmail(
      String nomeCompleto,
      String email,
      String celular,
      String mensagem
      ) async {
  final emailService = EmailService();

  String emailBody = '''
        Nome Completo: $nomeCompleto
        Email: $email
        Celular: $celular
        Mensagem: $mensagem
  ''';

    await emailService.sendEmail(
      fromEmail: 'renata.porto.gransoti@gmail.com',
      fromName: nomeCompleto,
      subject: 'Nova mensagem enviada pelo aplicativo!',
      body: emailBody,
    );
  }
  Future<void> _handleRefresh() async {
    await fetchHorarios();
    await fetchContactDetails();
  }

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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[200],
    child:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text('Entre em contato:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
              GestureDetector(
                onTap: () {
                  _launchPhone();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "$phoneNumber - Ligar agora",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  abrirWhatsapp(phoneNumber, 'Olá!');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
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
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Enviar Mensagem",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Nos acompanhe nas redes sociais:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, )),
              const SizedBox(height: 20),
              //abrirInstagram();
          GestureDetector(
            onTap: () {
              _abrirInstagram();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.instagram, color: Color(0xFFF50057), size: 24),
                  const SizedBox(width: 10),
                  Text(
                    instagramUsername.isNotEmpty ? '@$instagramUsername' : 'Instagram',
                    style: const TextStyle(fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF036896),
                      decorationThickness: 1,
                      ),
                  ),
                ],
              ),
            ),
          ),
              const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              _abrirFacebook();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF3F51B5), size: 24),
                SizedBox(width: 10),
                Text(
                   'pnsgracalondrina' ,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF036896),
                    decorationThickness: 1,
                  ),
                ),
              ],
            ),
          ),
              const SizedBox(height: 30),
              const Text(
                'HORÁRIOS:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildHorarioTile("Secretaria Paroquial", 'secretaria'),
              _buildHorarioTile("Missas", 'missa'),
              _buildHorarioTile("Confissões", 'confissão'),

              const SizedBox(height: 20),
              const Image(image: AssetImage('assets/images/mapa_paroquia.png')),
              const Text("Endereço: Rua Luís Dias, 393 - Petrópolis\n Londrina - PR", textAlign: TextAlign.center),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    ),);
  }

  Widget _buildHorarioTile(String titulo, String tipo) {
    var horariosList = horarios[tipo];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: const Color(0xFF036896),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: ExpansionTile(
          shape: const Border(),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          iconColor: Colors.white,
          children: [
            if (horariosList != null && horariosList.isNotEmpty)
              Column(
                children: horariosList.map<Widget>((horario) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Text(
                      horario['descricao'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            if (horariosList == null || horariosList.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
