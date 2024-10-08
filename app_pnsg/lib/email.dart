import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class EmailService {
  final String username = 'renata.porto.gransoti@gmail.com';
  final String password = 'ahpgpdyusnznyoif';
  late final smtpServer;

  EmailService() {
    smtpServer = gmail(username, password);
  }

  Future<String> _fetchContactEmail() async {
    try {
      final response = await http.get(Uri.parse('${Config.baseUrl}contatosapi'));

      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body) as Map<String, dynamic>;
        if (parsedJson['email'] != null && parsedJson['email'].isNotEmpty) {
          return parsedJson['email'][0]['valor'];
        } else {
          throw Exception('Nenhum e-mail encontrado');
        }
      } else {
        throw Exception('Falha ao carregar os detalhes de contato');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os detalhes de contato: $e');
      }
      rethrow; // Re-lança a exceção para que o chamador possa lidar com ela
    }
  }

  Future<void> sendEmail({
    required String fromEmail,
    required String fromName,
    required String subject,
    required String body,
  }) async {
    final contactEmail = await _fetchContactEmail();

    final message = Message()
      ..from = Address(fromEmail, fromName)
      ..recipients.add(contactEmail)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Message not sent. \n$e');
      }
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }
  }
}
