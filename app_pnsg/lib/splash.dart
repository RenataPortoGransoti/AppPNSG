import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/inicio.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: Center(
          child: Container(
            child: Image.asset('assets/images/brasao_pnsg.jpg', scale:1),
          ),
        )
    );
  }
}