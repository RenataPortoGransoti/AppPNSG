import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchCsrfToken() async {
  try {
    final Uri uri = Uri.parse('http://192.168.1.5:8000/csrf-token'); // Substitua pela rota correta do seu backend para obter o token CSRF
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Recupera o token CSRF do corpo da resposta
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String csrfToken = responseData['csrfToken'];
      return csrfToken;
    } else {
      throw Exception('Falha ao obter o token CSRF');
    }
  } catch (e) {
    print('Erro ao obter token CSRF: $e');
    throw e; // Lança o erro para ser tratado onde a função for chamada
  }
}
