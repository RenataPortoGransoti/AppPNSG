import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {
  final String nomeEvento;
  final String dataInicio;
  final String? dataFim;
  final String local;
  final String descricao;

  const EventoWidget({super.key, 
    required this.nomeEvento,
    required this.dataInicio,
    this.dataFim,
    required this.local,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateFormat outputFormat = DateFormat('dd/MM/yyyy HH:mm');

    // Verificação da data de início
    DateTime? parsedDataInicio;
    try {
      if (dataInicio.isNotEmpty) {
        parsedDataInicio = inputFormat.parse(dataInicio);
      }
    } catch (e) {
      parsedDataInicio = null;
    }

    // Verificação da data de fim
    DateTime? parsedDataFim;
    if (dataFim != null && dataFim!.isNotEmpty) {
      try {
        parsedDataFim = inputFormat.parse(dataFim!);
      } catch (e) {
        parsedDataFim = null;
      }
    }

    String formattedDataInicio = parsedDataInicio != null ? outputFormat.format(parsedDataInicio) : 'Data não informada';
    String? formattedDataFim = parsedDataFim != null ? outputFormat.format(parsedDataFim) : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evento: $nomeEvento',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            'Data de Início: $formattedDataInicio',
            style: const TextStyle(fontSize: 16),
          ),
          if (formattedDataFim != null)
            Text(
              'Data de Fim: $formattedDataFim',
              style: const TextStyle(fontSize: 16),
            ),
          const SizedBox(height: 5),
          Text(
            'Local: $local',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'Descrição: $descricao',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
