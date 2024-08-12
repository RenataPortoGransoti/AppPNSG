import 'dart:convert';
import 'package:PNSG/Screens/pastoraisScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config.dart';
import 'EventoWidget.dart';
import 'contribua.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

class Eventos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventosState();
  }
}

class EventosState extends State<Eventos> {
  int currentPageIndex = 2;
  List<dynamic> eventos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEventos();
  }
  Future<void> fetchEventos() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}eventosapi'));
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
      print(e);
    }
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
            } else if (currentPageIndex == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Informacoes())
              );
            }
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.lightBlue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage('assets/images/terco_inter.jpg'),),//imagem ser cadastrada no painel admin
            SizedBox(height: 10.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Ação ao clicar em "Ver eventos salvos"
            //   },
            //   child: Text('Ver eventos salvos', style: TextStyle(
            //     fontSize: 18,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.lightBlue,
            //   ),
            // ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: eventos.length,
              padding: EdgeInsets.all(5),
              separatorBuilder: (context, index) => SizedBox(height: 15.0),
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return EventoWidget(
                  nome_evento: evento['nome_evento'],
                  data_inicio: evento['data_inicio'],
                  data_fim: evento['data_fim'],
                  local: evento['local'],
                  descricao: evento['descricao'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
