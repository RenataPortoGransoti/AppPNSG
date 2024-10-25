import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EsqueceuSenha extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail de redefinição enviado! Verifique sua caixa de entrada.')),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Erro ao enviar e-mail de redefinição.';
      if (e.code == 'user-not-found') {
        message = 'Nenhum usuário encontrado para esse email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Esqueceu a Senha"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Informe seu e-mail para receber o link de redefinição de senha.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                if (email.isNotEmpty) {
                  resetPassword(context, email);
                } else {
                  print('Por favor, insira um e-mail válido.');
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue[200],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 76, vertical: 12),
              ),
              child: Text('Enviar e-mail de redefinição'),
            ),
          ],
        ),
      ),
    );
  }
}
