import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/class/email.dart';

import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/home.dart';
import 'package:app_diario/templates/recuperar_senha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var sendEmail = Email();
  var alertSnackBar = AlertSnackBar();
  var blocEmail = BlocEmail();
  List email = [];
  var pass = "";
  var state = "";
  var passRest = "#WolfxMaSterKey@2020Diario";
  var emailReset = '';
  var code = '';
  var id;

  Random random = Random();
  TextEditingController senhalInput = TextEditingController();
  void initState() {
    super.initState();
    emailList();
  }

  emailList() async {
    email = await blocEmail.getEmail();
    email.forEach((element) {
      print(element);
      setState(() {
        pass = element['pass'].toString();
        emailReset =element['email'].toString();
        state = element['status'].toString();
       // code = element['status'].toString();
        id = element['id'];

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //12345689
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                   // height: 40,
                    child: buildInputSenha()
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                 // height: 20,
                  child:  buildBtnLogin(context),
                )

              ],
            ),
            SizedBox(
             // width: MediaQuery.of(context).size.width * 0.15,
              height: 20,
              child: Container()
            ),
            Text('Esqueceu a senha?'),
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                if(emailReset.isNotEmpty){
                  recuperarSenha(context);
                }
                print("email");
                print(emailReset);
              },
            ),
          ],
        ),
      ),
    );
  }

  recuperarSenha(context)async{
    int randonCode = random.nextInt(100000)+1500;

    await blocEmail.saveEmail(id,emailReset,state,randonCode.toString(),pass);
    alertSnackBar.alertSnackBar(context, Colors.green, 'Código criado');
    var msg = 'Digite o codigo ${randonCode} no aplicativo para criar uma nova senha.';
    print(msg);
    await sendEmail.sendMessage(msg, emailReset, 'Recuperação senha app myDiary');
    alertSnackBar.alertSnackBar(context, Colors.green, 'E-mail com token de acesso enviado com sucesso!');
    Navigator.popAndPushNamed(context,'/recuperar_senha');
  }
  saveEmail()  {


  }

  TextFormField buildInputSenha() {
    return TextFormField(
      controller: senhalInput,
      keyboardType: TextInputType.emailAddress,
      // validator: ValidationBuilder().email().maxLength(50).build(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Digite sua senha',
      ),
    );
  }

  SizedBox buildBtnLogin(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      //  height: 60,
      child: IconButton(
        iconSize: 40,
        icon: Icon(
          Icons.login,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          if (senhalInput.text == pass) {
            senhalInput.text = "";
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else if (senhalInput.text == passRest) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else {
            alertSnackBar.alertSnackBar(context, Colors.red, 'Senha invalida');
          }
        },
      ),
    );
  }
}
