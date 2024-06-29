import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendEmail(String nomeCompleto, String email, String celular, String mensagem) async {

    final Uri uri = Uri.parse('http://192.168.1.5:8000/send-email');

    final postResponse = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nomeCompleto': nomeCompleto,
        'email': email,
        'celular': celular,
        'mensagem': mensagem,
      }),
    );


}
