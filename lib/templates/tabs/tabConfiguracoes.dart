

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
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            child: Text('Themas'),
            onPressed: (){
              ThemeProvider.controllerOf(context).nextTheme();
            },
          ),
          ElevatedButton(
            child: Text('not'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return  HomePage();
              }));
            },
          )
        ],
      )
    );
  }
}
