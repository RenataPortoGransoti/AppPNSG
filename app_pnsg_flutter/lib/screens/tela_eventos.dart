import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/database_helper.dart';
import '../views/widgets/header_widget.dart';
import 'tela_eventos_salvos.dart';
import '../config.dart';
import '../logger.dart';
import 'navigation_bar.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  State<StatefulWidget> createState() {
    return EventosState();
  }
}

class EventosState extends State<Eventos> {
  int currentPageIndex = 2;
  List<dynamic> eventos = [];
  bool isLoading = true;
  bool hasInternet = true;
  User? user;
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(2);

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
        break;
      case 3:
        Navigator.pushNamed(context, '/Contribua');
        break;
      case 4:
        Navigator.pushNamed(context, '/Informações');
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
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    fetchEventos();
    _getUser();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
        isLoading = false;
      });
    } else {
      setState(() {
        hasInternet = true;
      });
    }
  }

  Future<void> fetchEventos() async {
    await checkInternetConnection();
    if (!hasInternet) return;

    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}api/eventosapi'));
      if (response.statusCode == 200) {
        setState(() {
          eventos = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar eventos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    await fetchEventos();
  }

  Future<void> _getUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

 Future<void> _saveEvent(String eventId, Map<String, dynamic> eventData) async {
  if (user != null) {
    final eventToSave = {
      'id': eventId.toString(),
      'nome_evento': eventData['nome_evento'] ?? 'Nome não informado',
      'data_inicio': eventData['data_inicio'] ?? 'Data não informada',
      'data_fim': eventData['data_fim'] ?? 'Data não informada',
      'local': eventData['local'] ?? 'Local não informado',
      'descricao': eventData['descricao'] ?? 'Descrição não informada',
    };

    logger.i('Tentando salvar evento: $eventToSave');

    try {
      await DatabaseHelper().saveEvent(eventToSave);

      if (mounted) { 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento salvo com sucesso!')),
        );
      }
    } catch (e) {
      logger.i('Erro ao salvar evento: $e');
      if (mounted) { 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao salvar evento.')),
        );
      }
    }
  } else {
    if (mounted) { 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa estar logado para salvar eventos.')),
      );
    }
  }
}

  String formatDate(String? dateTime) {
    if (dateTime == null) return 'Data não disponível';
    final date = DateTime.parse(dateTime);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatTime(String? dateTime) {
    if (dateTime == null) return 'Hora não disponível';
    final date = DateTime.parse(dateTime);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue[200],
        child: Column(
          children: [
            const HeaderWidget(title: "Eventos Paroquiais"),
            const SizedBox(height: 10.0),
             if (user != null)
               OutlinedButton(
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const SavedEvents()),
                   );
                 },
                 style: OutlinedButton.styleFrom(
                   side: const BorderSide(width: 2.0, color: Colors.lightBlue),
                 ),
                 child: const Text(
                   'Ver eventos salvos',
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
            const SizedBox(height: 10.0),
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue[200],
                ),
              )
                  : !hasInternet
                  ? const Center(
                child: Text(
                  "Sem acesso à internet",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return SizedBox(
                    width: 380,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.blue[100]!, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  evento['nome_evento'] ?? 'Nome do Evento',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Início: ${formatDate(evento['data_inicio'])} ${formatTime(evento['data_inicio'])}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                if (evento['data_fim'] != null)
                                  Text(
                                    'Fim: ${formatDate(evento['data_fim'])} ${formatTime(evento['data_fim'])}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  'Local: ${evento['local'] ?? 'Local não disponível'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  evento['descricao'] ?? 'Descrição do evento não disponível.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.bookmark,
                                  size: 30,
                                  color: Colors.blue[300],
                                ),
                                onPressed: () {
                                  _saveEvent(evento['id'].toString(), evento);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
    default: return -1; // Valor padrão se a rota não for encontrada
  }
}
