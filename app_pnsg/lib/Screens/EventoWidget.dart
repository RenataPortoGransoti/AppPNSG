import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl para usar o DateFormat

class EventoWidget extends StatelessWidget {
  final String nome_evento;
  final String data_inicio; // A data de início do evento como uma string
  final String local;
  final String descricao;

  EventoWidget({
    required this.nome_evento,
    required this.data_inicio,
    required this.local,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(data_inicio);
    String formattedDate = DateFormat('dd/MM/yy - HH:mm').format(startDate);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evento: $nome_evento',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Data de Início: $formattedDate',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            'Local: $local',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            'Descrição: $descricao',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
