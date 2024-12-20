import 'package:PNSG/screens/tela_splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/tela_pastorais.dart';
import 'screens/tela_inicio.dart';
import 'screens/tela_eventos.dart';
import 'screens/tela_contribua.dart';
import 'screens/tela_informacoes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppPnsg());
}

class AppPnsg extends StatelessWidget {
  const AppPnsg({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App PNSG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
        ),
      ),
      home: const Splash(),
      routes: {
        '/Inicio': (context) => const Inicio(),
        '/PastoraisScreen': (context) => const PastoraisScreen(),
        '/Eventos': (context) => const Eventos(),
        '/Contribua': (context) => const Contribua(),
        '/Informacoes': (context) => const Informacoes(),
      },
    );
  }
}


