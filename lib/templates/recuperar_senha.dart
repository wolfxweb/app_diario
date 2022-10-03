


import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/tabs/tabConfiguracoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({Key? key}) : super(key: key);

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {

  TextEditingController _codeController = TextEditingController();

  var alertSnackBar = AlertSnackBar();
  var blocEmail = BlocEmail();
  List email = [];
  var pass = "";
  var state = "";
  var emailReset = '';
  var code = '';
  var id;

  void initState() {
    super.initState();

    emailList();
  }

  emailList() async {
    email = await blocEmail.getEmail();
    email.forEach((element) {
      print("_RecuperarSenhaState");
      print(element);
      setState(() {
        pass = element['pass'].toString();
        emailReset =element['email'].toString();
        state = element['status'].toString();
        code = element['code'];
        id = element['id'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Digite o codigo enviado para o email cadastrado."),
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
        ],
      ),
    );
  }
  TextFormField buildInputSenha() {
    return TextFormField(
      controller: _codeController,
      keyboardType: TextInputType.number,
      // validator: ValidationBuilder().email().maxLength(50).build(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Código',
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
          print("recuperar senha");
          print(_codeController.text);
          print('code');
          print(code);
           if(_codeController.text == code){
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const TabConfiguracoes()),
             );
           }else{
             alertSnackBar.alertSnackBar(context,Colors.red,'Código invalido');
           }
        },
      ),
    );
  }
}
