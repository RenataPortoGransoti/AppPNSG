import 'package:flutter/material.dart';

class EventoWidget extends StatelessWidget {
  final String nome_evento;
  final String data_inicio;
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding:const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(

        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: 'Evento: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize:18,)),
                TextSpan(text: '$nome_evento\n', style:TextStyle(fontSize:18,)),
                TextSpan(text: 'Data de Início: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,)),
                TextSpan(text: '$data_inicio\n', style:TextStyle(fontSize:16,)),
                TextSpan(text: 'Local: ', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,)),
                TextSpan(text: ' $local\n', style:TextStyle(fontSize:16,)),
                TextSpan(text: 'Descrição: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,)),
                TextSpan(text: '$descricao\n', style:TextStyle(fontSize:16,)),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
