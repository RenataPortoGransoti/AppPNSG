import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {
  late final String _username;
  late final String _password;
  late final SmtpServer smtpServer;

  Email(String username, String password) {
    _username = username;
    _password = password;
    smtpServer = gmail(_username, _password);
  }

  Future<bool> sendMessage(String mensagem, String remetenteEmail, String remetenteNome, String assunto, {String nomeCompleto = '', String celular = ''}) async {
    final message = Message()
      ..from = Address(remetenteEmail, remetenteNome)
      ..recipients.add('renatagransoti@gmail.com') // Alterado para o endereço desejado
      ..subject = assunto
      ..text = 'Nome completo: $nomeCompleto\n'
          'Email para contato: $remetenteEmail\n'
          'Celular: $celular\n'
          'Mensagem: $mensagem';

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensagem enviada: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Mensagem não enviada.');
      for (var p in e.problems) {
        print('Problema: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
