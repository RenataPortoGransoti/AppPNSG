import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'evento_widget.dart';
import 'package:logger/logger.dart';

class SavedEvents extends StatefulWidget {
  const SavedEvents({super.key});

  @override
  State<StatefulWidget> createState() {
    return SavedEventsState();
  }
}

class SavedEventsState extends State<SavedEvents> {
  List<Map<String, dynamic>> _savedEvents = [];
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadSavedEvents();
  }

  Future<void> _loadSavedEvents() async {
    final events = await DatabaseHelper().getEvents();
    setState(() {
      _savedEvents = events;
    });
    if (events.isEmpty) {
       logger.i('Nenhum evento salvo.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos Salvos'),
      ),
      body: _savedEvents.isEmpty
          ? const Center(
        child: Text(
          'Nenhum evento salvo',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _savedEvents.length,
        itemBuilder: (context, index) {
          final event = _savedEvents[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                EventoWidget(
                  nomeEvento: event['nome_evento'] ?? 'Nome do Evento',
                  dataInicio: event['data_inicio'] ?? 'Data não disponível',
                  dataFim: event['data_fim'],
                  local: event['local'] ?? 'Local não disponível',
                  descricao: event['descricao'] ?? 'Descrição não disponível',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper().deleteEvent(event['id'] ?? '');
                      _loadSavedEvents();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
