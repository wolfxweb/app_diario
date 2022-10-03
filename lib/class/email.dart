import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {
  String _username = "";
  var smtpServer;

  final usernames = 'suporte@wolfx.com.br';
  final passwords = '8dhIbkUG02tTRLap';
  Email(){
    _username = usernames;
    smtpServer =   SmtpServer(
      'smtp-relay.sendinblue.com',
      port: 587,
      username: _username,
      password: passwords,
    );
  }
  //Envia um email para o destinatário, contendo a mensagem com o nome do sorteado
  Future<bool> sendMessage(String mensagem, String destinatario, String assunto) async {
    //Configurar a mensagem
    final message = Message()
      ..from = Address(_username, 'Wolfx Softwares')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..text = mensagem;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.problems);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}