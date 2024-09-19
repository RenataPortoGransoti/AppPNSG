import 'package:PNSG/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/pastoraisScreen.dart';
import 'Screens/PastoralEspecifica.dart';
import 'Screens/inicio.dart';
import 'Screens/eventos.dart';
import 'Screens/contribua.dart';
import 'Screens/informacoes.dart';
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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


