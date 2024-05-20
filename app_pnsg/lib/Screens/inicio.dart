   import 'package:flutter/material.dart';
  import 'eventos.dart';
  import 'navigation_bar.dart'; // Importe o widget CustomBottomNavigationBar
  import 'pastoraisScreen.dart';
  import 'contribua.dart';
  import 'informacoes.dart';

  class Inicio extends StatefulWidget {
    @override
    InicioState createState() => InicioState();
  }

  class InicioState extends State<Inicio> {
    int currentPageIndex = 0;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (currentPageIndex == 1) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30), // Margem vertical para espaçamento
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width - 70,
                decoration: BoxDecoration(
                  color: Color(0xFF036896),
                  borderRadius: BorderRadius.circular(15), // Ajuste este valor conforme necessário
                ),
                child: Text(
                  "Avisos Paroquiais",
                  textAlign: TextAlign.center, // Alinhe o texto ao centro
                  style: TextStyle(
                    fontSize: 20, // Tamanho da fonte
                    fontWeight: FontWeight.bold,
                    color: Colors.white,// Peso da fonte
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(30),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 70), // Defina a altura máxima desejada
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Orações",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 70), // Defina a altura máxima desejada
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Galeria',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 70), // Defina a altura máxima desejada
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Via Sacra",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 70), // Defina a altura máxima desejada
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'História da Paróquia',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),


              ),
            ],
          ),
        ),

      );
    }}

            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //     'Aplicativo Paróquia Nossa Senhora das Graças',
            //     style: TextStyle(fontSize: 24),
            //     textAlign: TextAlign.center,
            //   ),
            //   SizedBox(height: 20),
            //   ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => LoginScreen()),
            //       );
            //     },
            //     child: Text('Login'),
            //   ),


           // ],

  // ),
  //     );










