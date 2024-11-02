import 'package:PNSG/Screens/tela_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../email.dart';
import   '../views/dizimo_screen.dart';
import   '../views/doacao_screen.dart';
import 'formulario_dizimista.dart';
import 'tela_informacoes_dizimo.dart';
import 'navigation_bar.dart';

class Contribua extends StatefulWidget {
  const Contribua({super.key});

  @override
  State<StatefulWidget> createState() {
    return ContribuaState();
  }
}

class ContribuaState extends State<Contribua> {
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(3);

  final List<String> _navigationHistory = [];

  void _onDestinationSelected(int index) {
    _selectedIndexNotifier.value = index;

    if (index != 1) {
      _navigationHistory.add(_getRouteName(index));
    }

    switch (index) {
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
        break;
      case 4:
        Navigator.pushNamed(context, '/Informacoes');
        break;
    }
  }
  String _getRouteName(int index) {
    switch (index) {
      case 0: return '/Inicio';
      case 1: return '/Pastorais';
      case 2: return '/Eventos';
      case 3: return '/Contribua';
      case 4: return '/Informacoes';
      default: return '';
    }
  }

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
              content: const Text('Formulário enviado com sucesso. Deus abençoe. Aguarde nosso contato!'),
              backgroundColor: Colors.lightGreen[800],
              duration: const Duration(seconds: 4),
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

  void _checkAuthAndShowForm(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      _mostrarFormularioDizimista(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigationHistory.isNotEmpty) {
          String previousRoute = _navigationHistory.removeLast();
          int previousIndex = _getIndexFromRoute(previousRoute);
          _selectedIndexNotifier.value = previousIndex;
          Navigator.pushReplacementNamed(context, previousRoute);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          onDestinationSelected: _onDestinationSelected,
          selectedIndex: _selectedIndexNotifier.value,
          backgroundColor: Colors.lightBlue,
        ),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        const Padding(
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
            const SizedBox(height: 10),
            const Text(
              "Formas de Contribuir",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DizimoScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(18),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
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
                      MaterialPageRoute(builder: (context) => const DoacaoScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(18),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
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
                _checkAuthAndShowForm(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF036896),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Ser Dizimista",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.9; // 50% da largura da tela
                return Image.asset(
                  'assets/images/donation.png',
                  width: imageSize,
                );
              },
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformacoesDizimo()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: Color(0xFF036896)),
              ),
              child: const Text(
                'Saber mais sobre o Dízimo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
                ),
              ]),
            ),
      ),
    ),);
  }
}

int _getIndexFromRoute(String route) {
  switch (route) {
    case '/Inicio': return 0;
    case '/Pastorais': return 1;
    case '/Eventos': return 2;
    case '/Contribua': return 3;
    case '/Informações': return 4;
    default: return -1;
  }
}