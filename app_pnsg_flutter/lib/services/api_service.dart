import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

Future<String?> fetchCSRFToken(String baseUrl) async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    dom.Document document = parser.parse(response.body);
    var metaTags = document.getElementsByTagName('meta');

    String? csrfToken = '';

    // Encontrar a meta tag com o nome csrf-token
    for (var tag in metaTags) {
      if (tag.attributes['name'] == 'csrf-token') {
        csrfToken = tag.attributes['content'];
        break;
      }
    }

    return csrfToken;
  } else {
    throw Exception('Falha ao carregar o token CSRF');
  }
}
