import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dizimo_model.dart';
import '../config.dart';

class DizimoController {
  Future<DizimoModel?> fetchDizimoData() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}api/dizimoapi'));
    if (response.statusCode == 200) {
      List<dynamic> dizimos = json.decode(response.body);
      if (dizimos.isNotEmpty) {
        return DizimoModel.fromJson(dizimos[0]);
      }
    } else {
      throw Exception('Falha ao carregar dízimos');
    }
    return null;
  }
}
