import 'package:flutter/material.dart';
import '../database_helper.dart';

class SavedEvents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SavedEventsState();
  }
}

class SavedEventsState extends State<SavedEvents> {
  List<Map<String, dynamic>> _savedEvents = [];

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
      print('Nenhum evento salvo.'); // Log para depuração
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos Salvos'),
      ),
      body: _savedEvents.isEmpty
          ? Center(
        child: Text(
          'Nenhum evento salvo',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _savedEvents.length,
        itemBuilder: (context, index) {
          final event = _savedEvents[index];
          return ListTile(
            title: Text(event['nome_evento'] ?? 'Nome do Evento'),
            subtitle: Text('Início: ${event['data_inicio'] ?? 'Data não disponível'}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseHelper().deleteEvent(event['id'] ?? '');
                _loadSavedEvents();
              },
            ),
          );
        },
      ),
    );
  }
}
