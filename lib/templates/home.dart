


import 'package:app_diario/components/app_bar_component.dart';
import 'package:app_diario/components/bottom_navigation_bar_component.dart';
import 'package:app_diario/templates/tabs/note.dart';
import 'package:app_diario/templates/tabs/tabAgenda.dart';
import 'package:app_diario/templates/tabs/tabConfiguracoes.dart';
import 'package:app_diario/templates/tabs/tabHome.dart';
import 'package:app_diario/templates/tabs/tabRelatorios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var header = AppBarComponete();

    var cor = Theme.of(context).primaryColor;
    if(Theme.of(context).primaryColor != '0xff424242'){
      cor = Colors.white;
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar:  header.getAppBar(AppLocalizations.of(context)!.app_bar_title, context),
          body: TabHome(),
        floatingActionButton:FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return  TabNote();
            }));
          },
          backgroundColor: Theme.of(context).primaryColor,

          child:  Icon(Icons.add, color: cor,),
        ),
      ),
    );
   }
}
