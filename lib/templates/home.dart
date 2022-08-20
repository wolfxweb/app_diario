


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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar:  header.getAppBar(AppLocalizations.of(context)!.app_bar_title, context),
          body: const TabBarView(
            children: [
              TabHome(),
              TabAgenda(),
              TabNote(),
              TabRelatorios(),
              TabConfiguracoes(),
            ],
          ),
          bottomNavigationBar: const ButtomNavidateBarComponent(),
      ),
    );
   }
}
