import 'package:app_pnsg/Screens/pastoraisScreen.dart';
import 'package:flutter/material.dart';
import 'eventos.dart';
import 'informacoes.dart';
import 'inicio.dart';
import 'navigation_bar.dart';

class Contribua extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ContribuaState();
  }
}

class ContribuaState extends State<Contribua> {
  int currentPageIndex = 3;

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
          }else if (currentPageIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PastoraisScreen()),
            );
          }else if(currentPageIndex == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Eventos()),
            );
          }else if(currentPageIndex == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contribua()),
            );
          }else if(currentPageIndex == 4){
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

        body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       '"Dê cada um conforme o impulso do seu coração, sem tristeza nem constrangimento. Deus ama o que dá com alegria" II Cor 9:7',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: Text('Dízimo'),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(150, 80),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: Text('Doação'),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(150, 80),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) => DizimistaDialog(),
//                         );
//                       },
//                       child: Text('Ser Dizimista'),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(320, 50),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'assets/images/donation.png', // Make sure to add the image to your assets
//                       height: 150,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Para onde vai o dinheiro do dízimo?',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),);
//   }}
//
// class DizimistaDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: SingleChildScrollView(
//         child: const Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Nome completo'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Celular'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Nome do cônjuge'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Endereço'),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(labelText: 'N'),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(labelText: 'Apto'),
//                   ),
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Bairro'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'CEP'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Data de Nascimento'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Data de Nascimento do Cônjuge'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'E-mail'),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Text(
//                 'Em nossa família, reconhecemos tudo que recebemos de Deus. Como agradecimento e ato de amor a Deus, queremos contribuir mensalmente com o Dízimo atendendo à Dimensão Religiosa, Social e Missionária de nossa Comunidade.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             SizedBox(height: 20),
//             // ElevatedButton(
//             //   onPressed: () {
//             //
//             //   },
//             //   child: Text('Cadastrar'),
//             // ),
//
//         ]),
//
//       ));
//   }
  ));}}