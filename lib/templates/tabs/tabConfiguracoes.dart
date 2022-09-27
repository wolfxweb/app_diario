import 'package:app_diario/templates/home_page.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';

class TabConfiguracoes extends StatefulWidget {
  const TabConfiguracoes({Key? key}) : super(key: key);

  @override
  State<TabConfiguracoes> createState() => _TabConfiguracoesState();
}

class _TabConfiguracoesState extends State<TabConfiguracoes> {
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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
          child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
              child: Column(

                children: [
                 const  Text("Themes Light",  style: TextStyle( fontSize:24),),
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
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
              child: Column(
                children: [
                  const  Text("Themes Dark",  style: TextStyle( fontSize:24),),
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
          )
        ],
      )),
    );
  }

  ElevatedButton buildElevatedButton(
      BuildContext context, String titulo, String thema, cor) {
    return ElevatedButton(
      child: Text(titulo),
      onPressed: () {
        ThemeProvider.controllerOf(context).setTheme(thema);
      },
      style: ElevatedButton.styleFrom(
        primary: cor,
      ),
    );
  }
}
