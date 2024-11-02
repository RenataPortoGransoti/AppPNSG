import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/doacao_model.dart';

class DoacaoController {

  Future<DoacaoModel?> fetchDizimoData() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}api/doacaoapi'));
    if (response.statusCode == 200) {
      List<dynamic> doacoes = json.decode(response.body);
      if (doacoes.isNotEmpty) {
        return DoacaoModel.fromJson(doacoes[0]);
      }
    } else {
      throw Exception('Falha ao carregar dízimos');
    }
    return null;
  }
}
