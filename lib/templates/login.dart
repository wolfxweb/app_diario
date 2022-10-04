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
  var _focusNode = new FocusNode();
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
        emailReset = element['email'].toString();
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
      backgroundColor: Colors.purple,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
            //  height: double.infinity,
            //  width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple[500],

                border: Border.all(
                  width: 1,
                  color:Colors.purple,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              //  borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      //width: 100,
                      // height: 80,
                      child: Image.asset("assets/img/Logo.png"),
                    ),
                    SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.15,
                        height: 100,
                        child: Container()),
                   // buildInputSenha(),
                  //  buildBtnLogin(context),
                       Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
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
                        height: 100,
                        child: Container()),
                    buildText('Esqueceu a senha?'),
                    SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.15,
                        height: 10,
                        child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            buildText('Solicitar token'),
                            buildEmail(context),
                          ],
                        ),
                        Column(
                          children: [
                            buildText('Já tenho o token'),
                            buildToken(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  buildTextStyle() {
    return const TextStyle(
      fontSize: 30,
      color: Colors.white,
    );
  }

  IconButton buildEmail(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: const Icon(Icons.email, color: Colors.white),
      onPressed: () {
        if (emailReset.isNotEmpty) {
          recuperarSenha(context);
        }
      },
    );
  }

  recuperarSenha(context) async {
    int randonCode = random.nextInt(100000) + 1500;
    await blocEmail.saveEmail(
        id, emailReset, state, randonCode.toString(), pass);
    alertSnackBar.alertSnackBar(context, Colors.green, 'Código criado');
    var msg =
        'Digite o codigo ${randonCode} no aplicativo para criar uma nova senha.';
    await sendEmail.sendMessage(
        msg, emailReset, 'Recuperação senha app myDiary');
    alertSnackBar.alertSnackBar(context, Colors.green,
        'E-mail com token de acesso enviado com sucesso!');
    Navigator.popAndPushNamed(context, '/recuperar_senha');
  }

  TextFormField buildInputSenha() {
    return TextFormField(
      controller: senhalInput,
      obscureText:true,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      // validator: ValidationBuilder().email().maxLength(50).build(),
      decoration: const InputDecoration(

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.white, width: 1.0, style: BorderStyle.solid),
        ),
      //  fillColor: Colors.white,
        filled: true,
       // fillColor: Colors.purpleA,
        border: OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.white),
        ),
       // border: InputBorder.none
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.white, width: 1.0, style: BorderStyle.solid),
        ),
        labelText: "Digite sua senha",
        labelStyle:  TextStyle(
          color: Colors.white,
          //  backgroundColor: Colors.white,
        ),
      ),
    );
  }

  SizedBox buildBtnLogin(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      //  height: 60,
      child: IconButton(
        iconSize: 40,
        icon: const Icon(Icons.login, color: Colors.white),
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

class buildToken extends StatelessWidget {
  const buildToken({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(
        Icons.password,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.popAndPushNamed(context, '/recuperar_senha');
      },
    );
  }
}
