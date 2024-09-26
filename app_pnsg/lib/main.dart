import 'package:PNSG/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/tela_pastorais.dart';
import 'Screens/tela_pastoral_especifica.dart';
import 'Screens/tela_inicio.dart';
import 'Screens/tela_eventos.dart';
import 'Screens/tela_contribua.dart';
import 'Screens/tela_informacoes.dart';
import 'config.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppPnsg());
}

class AppPnsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App PNSG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
        ),
      ),
      home: Splash(), // Tela inicial de splash
      routes: {
        '/Inicio': (context) => Inicio(),
        '/PastoraisScreen': (context) => PastoraisScreen(),
        '/Eventos': (context) => Eventos(),
        '/Contribua': (context) => Contribua(),
        '/Informacoes': (context) => Informacoes(),
      },
    );
  }
}


