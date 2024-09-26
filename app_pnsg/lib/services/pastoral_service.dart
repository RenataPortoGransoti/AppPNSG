import 'package:http/http.dart' as http;
import 'dart:convert';

class PastoralService {
  Future<List<dynamic>> fetchPastorais() async {
    final response = await http.get(Uri.parse('http://localhost:8000/pastoraisapi'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados das pastorais');
    }
  }
}
