import 'package:flutter/material.dart';
import 'Screens/PastoralEspecifica.dart';
import 'Screens/inicio.dart';

class appPNSG extends StatelessWidget {
  final bool isLoggedIn;

  appPNSG(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App PNSG',
      home: isLoggedIn ? Inicio() : Inicio(),
      onGenerateRoute: (settings) {
        if (settings.name == '/PastoralEspecifica') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return PastoralEspecifica(
                nome: args['nome'],
                descricao: args['descricao'],
                imagem: args['imagem'],
              );
            },
          );
        }
        return null; // Para qualquer outra rota, pode retornar null
      },
    );
  }
}
