import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/components/alert_modal.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/home_page.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:form_validator/form_validator.dart';

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
    //  print(element);
      setState(() {
        status = int.parse(element['status']);
        emailInput.text = element['email'].toString();
        senhalInput.text = element['pass'].toString();
        id = element['id'];
        if(element['id'] != 0){
          emailBool = false;
        }
      });
    });
    print('email tab confg');
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: false,
        title: const Text(
          'Configurações',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
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
                           const Text(
                              "Ativa senha?",
                              style: TextStyle(fontSize: 24),
                            ),
                            ToggleSwitch(
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
                              labels: ['True', 'False'],
                              radiusStyle: true,
                              onToggle: (index) {
                                if (emailInput.text.isEmpty && status == 1) {
                                  alertModal.openModal(context,
                                      "Para ativar este recurso o email de recuperação de senha deve ser informado");
                                }
                                setState(() {
                                  status = index!;
                                });
                                saveEmail();
                              },
                            ),
                          ],
                        ),
                        buildSizedBox(),
                        if (status != 1)
                        emailBool?buildInputs(context): ElevatedButton(
                          onPressed: () {
                            setState(() {
                              emailBool = !emailBool;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            // primary: cor,
                          ),
                          child: !emailBool?Text("Editar senha cadastrada"):Text("Cadastrar senha"),
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite o seu email',
            ),
          ),
        ),
        buildSizedBox(),
        SizedBox(
          // width: MediaQuery.of(context).size.width * 0.73,
          //  height: 50,
          child: TextFormField(
            controller: senhalInput,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().email().maxLength(50).build(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite sua senha',
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
                    Navigator.popAndPushNamed(context,'/configuracao');
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
                    saveEmail();
                    setState(() {
                      emailBool = !emailBool;
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

  saveEmail()  {
    var st = '0';
    if(status == 1){
      st = '1';
    }
    print('status');
    print(status.runtimeType.toString());
    print('status');
    blocEmail.saveEmail(id,emailInput.text,st,'0',senhalInput.text);
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Adicione o email',
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
            const Text(
              "Themes Light",
              style: TextStyle(fontSize: 24),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildElevatedButton(
                      context,
                      'Light',
                      'theme_1',
                      Colors.blue,
                    ),
                    buildElevatedButton(
                      context,
                      'Purple',
                      'theme_2',
                      Colors.deepPurple,
                    ),
                    buildElevatedButton(
                      context,
                      'Pink',
                      'theme_5',
                      Colors.pink,
                    ),
                    buildElevatedButton(
                      context,
                      'LightGreen',
                      'theme_6',
                      Colors.lightGreen,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildElevatedButton(
                      context,
                      'Orange',
                      'theme_7',
                      Colors.orange,
                    ),
                    buildElevatedButton(
                      context,
                      'Grey',
                      'theme_8',
                      Colors.grey,
                    ),
                    buildElevatedButton(
                      context,
                      'Teal',
                      'theme_9',
                      Colors.teal,
                    ),
                    buildElevatedButton(
                      context,
                      'Brown',
                      'theme_10',
                      Colors.brown,
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
            const Text(
              "Themes Dark",
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildElevatedButton(
                  context,
                  'Dark',
                  'theme_3',
                  Colors.black54,
                ),
                buildElevatedButton(
                  context,
                  'Purple',
                  'theme_4',
                  Colors.deepPurple,
                ),
                buildElevatedButton(
                  context,
                  'Pink',
                  'theme_11',
                  Colors.pink,
                ),
                buildElevatedButton(
                  context,
                  'LightGreen',
                  'theme_12',
                  Colors.lightGreen,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildElevatedButton(
                  context,
                  'Orange',
                  'theme_13',
                  Colors.orange,
                ),
                buildElevatedButton(
                  context,
                  'Grey',
                  'theme_14',
                  Colors.grey,
                ),
                buildElevatedButton(
                  context,
                  'Teal',
                  'theme_15',
                  Colors.teal,
                ),
                buildElevatedButton(
                  context,
                  'Brown',
                  'theme_16',
                  Colors.brown,
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
        alertSnackBar.alertSnackBar(context, cor, "Thema alterado com sucesso");
      },
      style: ElevatedButton.styleFrom(
        primary: cor,
      ),
      child: Text(titulo),
    );
  }
}
