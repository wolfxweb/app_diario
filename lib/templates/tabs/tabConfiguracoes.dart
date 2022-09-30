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

  var alertSnackBar = AlertSnackBar();
  var alertModal = AlertModal();
  int status = 1;
  TextEditingController emailInput = TextEditingController();
  void initState() {
    super.initState();
    status = 1;
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
                            Text("Ativa senha?", style: TextStyle(fontSize: 24),),
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
                                if(emailInput.text.isEmpty && status ==1){
                                   alertModal.openModal(context, "Para ativar este recurso o email de recuperação de senha deve ser informado");
                                }
                                _saveAtivarSenha(index);
                                setState(() {
                                  status = index!;
                                });
                                print('switched to: $index');
                              },
                            ),
                          ],
                        ),
                        buildSizedBox(),
                        if (status != 1)
                          buildRowEmail(context)
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

  Row buildRowEmail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          //  height: 40,
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
          width: MediaQuery.of(context).size.width * 0.23,
          height: 60,
          child: ElevatedButton(
            child: const Text('Salvar'),
            onPressed: () {
              if(emailInput.text.isEmpty){
               return  alertModal.openModal(context, "Campo email e obrigatorio");
              }


            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  _saveAtivarSenha(int? index) {

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
      child: Text(titulo),
      onPressed: () {
        ThemeProvider.controllerOf(context).setTheme(thema);
        alertSnackBar.alertSnackBar(context, cor, "Thema alterado com sucesso");
      },
      style: ElevatedButton.styleFrom(
        primary: cor,
      ),
    );
  }
}
