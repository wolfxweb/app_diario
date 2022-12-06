import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/components/alert_modal.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/components/anuncio_banner.dart';
import 'package:app_diario/templates/home_page.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabConfiguracoes extends StatefulWidget {
  const TabConfiguracoes({Key? key}) : super(key: key);

  @override
  State<TabConfiguracoes> createState() => _TabConfiguracoesState();
}

class _TabConfiguracoesState extends State<TabConfiguracoes> {
  var blocEmail = BlocEmail();
  var alertSnackBar = AlertSnackBar();
  var alertModal = AlertModal();
  var id = null;
  var emailBool = true;
  List email = [];
  int status = 1;
  TextEditingController emailInput = TextEditingController();
  TextEditingController senhalInput = TextEditingController();
  void initState() {
    super.initState();
    status = 1;
    emailList();
  }

  emailList() async {
    email = await blocEmail.getEmail();
    email.forEach((element) {
      print("element");
      print(element);
      setState(() {
        status = int.parse(element['status']);
        emailInput.text = element['email'].toString();
        senhalInput.text = element['pass'].toString();
        id = element['id'];
        if (element['id'] != 0) {
          emailBool = false;
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: false,
        title:  Text(
            AppLocalizations.of(context)!.configuracaoes,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                AnuncioBanner(),
                buildCardLight(context),
                buildCardDark(context),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(

                              AppLocalizations.of(context)!.ativar_senha,
                              style: TextStyle(fontSize: 18),
                            ),
                            buildToggleSwitch(context),
                          ],
                        ),
                        buildSizedBox(),
                        if (status != 1)
                          emailBool
                              ? buildInputs(context)
                              : ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      emailBool = !emailBool;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      // primary: cor,
                                      ),
                                  child: !emailBool
                                      ? Text( AppLocalizations.of(context)!.edt_editando_senha)
                                      : Text(AppLocalizations.of(context)!.senha_cadastro),
                                )
                        else
                          Container(),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  ToggleSwitch buildToggleSwitch(BuildContext context) {
    return ToggleSwitch(
      minWidth: 60.0,
      //   cornerRadius: 20.0,
      activeBgColors: [
        [Colors.green[800]!],
        [Colors.red[800]!]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: status,
      totalSwitches: 2,
      labels: [AppLocalizations.of(context)!.btn_ativar_senha_true, AppLocalizations.of(context)!.btn_ativar_senha_false],
      radiusStyle: true,
      onToggle: (index) {
        if (emailInput.text.isEmpty && status == 1) {
          alertModal.openModal(context,
              AppLocalizations.of(context)!.ativar_senhas);
        }
        setState(() {
          status = index!;
        });
      //  saveEmail();
        var emailSalvo = saveEmail();

        var alert = AlertSnackBar();
        emailSalvo.then((response)=>{

          if(response == 1){
            alert.alertSnackBar(context, Colors.green, AppLocalizations.of(context)!.sucesso)
          }
        });
      },
    );
  }

  Column buildInputs(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          //  width: MediaQuery.of(context).size.width * 0.73,
          // height: 50,
          child: TextFormField(
            controller: emailInput,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().email().maxLength(50).build(),
            decoration:  InputDecoration(
              border: OutlineInputBorder(),
              hintText:  AppLocalizations.of(context)!.digite_email,
            ),
          ),
        ),
        buildSizedBox(),
        SizedBox(
          // width: MediaQuery.of(context).size.width * 0.73,
          //  height: 50,
          child: TextFormField(
            controller: senhalInput,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().email().maxLength(50).build(),
            decoration:  InputDecoration(
              border: OutlineInputBorder(),
              hintText: AppLocalizations.of(context)!.digite_password,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                //  height: 60,
                child: IconButton(
                  iconSize: 40,
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    //blocEmail.saveEmail(id,emailInput.text, '0', '',senhalInput.text);
                    //saveEmail();
                    setState(() {
                      emailBool = !emailBool;
                    });
                    Navigator.popAndPushNamed(context, '/configuracao');
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                //  height: 60,
                child: IconButton(
                  iconSize: 40,
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // blocEmail.saveEmail(id,emailInput.text, '0', '',senhalInput.text);
                   var emailSalvo = saveEmail();

                   var alert = AlertSnackBar();
                   emailSalvo.then((response)=>{

                     if(response == 1){
                       alert.alertSnackBar(context, Colors.green, AppLocalizations.of(context)!.sucesso)
                     }
                   });
                    setState(() {
                    //  emailBool = !emailBool;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  saveEmail() async{
    var st = '0';
    if (status == 1) {
      st = '1';
    }
   return  await blocEmail.saveEmail(id, emailInput.text, st, '0', senhalInput.text);
  }

  Row buildRowEmail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.73,
          height: 50,
          child: TextFormField(
            controller: emailInput,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().email().maxLength(50).build(),
            decoration:  InputDecoration(
              border: const OutlineInputBorder(),
              hintText: AppLocalizations.of(context)!.digite_email,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          height: 60,
          child: IconButton(
            iconSize: 50,
            icon: Icon(
              Icons.save,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              //  blocEmail.saveEmail(id,emailInput.text, '0', '',senhalInput.text);
            },
          ),
        ),
      ],
    );
  }

  SizedBox buildSizedBox() => SizedBox(
        height: 10.0,
        child: Container(),
      );

  Card buildCardLight(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
             Text(
              AppLocalizations.of(context)!.tema_light,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              // width: 30.0,
              height: 15.0,
              child: Container(),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        '',
                        'theme_1',
                        Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Purple',
                        'theme_2',
                        Colors.deepPurple,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Pink',
                        'theme_5',
                        Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'LightGreen',
                        'theme_6',
                        Colors.lightGreen,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Orange',
                        'theme_7',
                        Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Grey',
                        'theme_8',
                        Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Teal',
                        'theme_9',
                        Colors.teal,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: buildElevatedButton(
                        context,
                        'Brown',
                        'theme_10',
                        Colors.brown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardDark(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
             Text(
               AppLocalizations.of(context)!.tema_dark,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              // width: 30.0,
              height: 15.0,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    '',
                    'theme_3',
                    Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    '',
                    'theme_4',
                    Colors.deepPurple,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    '',
                    'theme_11',
                    Colors.pink,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    '',
                    'theme_12',
                    Colors.lightGreen,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    '',
                    'theme_13',
                    Colors.orange,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    'Grey',
                    'theme_14',
                    Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    'Teal',
                    'theme_15',
                    Colors.teal,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: buildElevatedButton(
                    context,
                    'Brown',
                    'theme_16',
                    Colors.brown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  ElevatedButton buildElevatedButton(
      BuildContext context, String titulo, String thema, cor) {
    return ElevatedButton(
      onPressed: () {
        ThemeProvider.controllerOf(context).setTheme(thema);
        alertSnackBar.alertSnackBar(context, cor, AppLocalizations.of(context)!.sucesso);
      },
      style: ElevatedButton.styleFrom(
        primary: cor,
      ),
      child: Text(titulo),
    );
  }
}
