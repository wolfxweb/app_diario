


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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/fundo.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
               //width: 100,
               height: 300,
              margin: EdgeInsets.only(left: 20, top: 100, right:20, bottom: 50),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,


                children: [


                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.15,
                      height: 50,
                      child: Container()),
                const   Text("Digite o codigo enviado para o email cadastrado.", style: TextStyle(color: Colors.white),),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.15,
                      height:20,
                      child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
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
                      height:50,
                      child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                   /*   Column(
                        children: [
                          buildText('Solicitar token'),
                          buildEmail(context,'/recuperar_senha',Icon(Icons.email, color: Colors.white)),
                        ],
                      ),*/
                      Column(
                        children: [
                        //  buildText('Inicio'),
                          buildEmail(context,'/splashscreen',Icon(Icons.undo, color: Colors.white)),
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
    );
  }
  Text buildText(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
  IconButton buildEmail(BuildContext context, rota, icon) {
    return IconButton(
      iconSize: 40,
      icon:  icon, //const Icon(Icons.email, color: Colors.white),
      onPressed: () {
        Navigator.popAndPushNamed(context, rota);
      },
    );
  }

  TextFormField buildInputSenha() {
    return TextFormField(
      controller: _codeController,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
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
        labelText: "Digite o token",
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
        icon: Icon(
          Icons.login,
          color: Colors.white,
        ),
        onPressed: () {
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
