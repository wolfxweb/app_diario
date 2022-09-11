import 'package:app_diario/templates/home_page.dart';

import 'package:app_diario/templates/tabs/note.dart';
import 'package:app_diario/templates/tabs/tabConfiguracoes.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class AppBarComponete {
  getAppBar(String title, context) {
    return AppBar(
      leading: IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return   TabConfiguracoes();
        }));


       // Navigator.popAndPushNamed(context,'/');
      },icon:const Icon(Icons.person_pin) ,),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      //  automaticallyImplyLeading: _automaticallyImplyLeading,
      centerTitle: true,
      elevation: 15,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return  TabNote();
            }));

         // Navigator.push(context, HomePage());
        //    Navigator.pop(ctx, MediaPickSetting.Video),
          //  ThemeProvider.controllerOf(context).nextTheme();
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
