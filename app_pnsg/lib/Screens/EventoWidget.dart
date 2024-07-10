import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {
  final String nome_evento;
  final String data_inicio; // A data de início do evento como uma string
  final String? data_fim; // Usar String? para aceitar nulo
  final String local;
  final String descricao;

  EventoWidget({
    required this.nome_evento,
    required this.data_inicio,
    this.data_fim,
    required this.local,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateFormat outputFormat = DateFormat('dd/MM/yy HH:mm');

    DateTime parsedDataInicio = inputFormat.parse(data_inicio);
    DateTime? parsedDataFim;

    if (data_fim != null && data_fim!.isNotEmpty) {
      parsedDataFim = inputFormat.parse(data_fim!);
    }

    String formattedDataInicio = outputFormat.format(parsedDataInicio);
    String? formattedDataFim = parsedDataFim != null ? outputFormat.format(parsedDataFim) : null;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(20), // Espaçamento interno fixo
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
            'Data de Início: $formattedDataInicio',
            style: TextStyle(fontSize: 16),
          ),
          if (formattedDataFim != null) // Mostra apenas se formattedDataFim não for nulo
            Text(
              'Data de Fim: $formattedDataFim',
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
