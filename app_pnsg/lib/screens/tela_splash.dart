import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/tela_inicio.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Torna a barra de status transparente
    ));
    Future.delayed(const Duration(seconds: 1)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
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