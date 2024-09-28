import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela_inicio.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Torna a barra de status transparente
    ));
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Inicio()),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo da splash
      body: Center(
        child: Image.asset(
          'assets/images/brasao_pnsg.jpg',
          fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela
        ),
      ),
    );
  }

}