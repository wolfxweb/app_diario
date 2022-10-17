

import 'package:app_diario/bloc/blocEmail.dart';
import 'package:app_diario/config/theme_setup.dart';
import 'package:app_diario/templates/home.dart';
import 'package:app_diario/templates/recuperar_senha.dart';
import 'package:app_diario/templates/splashscreen.dart';
import 'package:app_diario/templates/tabs/tabAgenda.dart';
import 'package:app_diario/templates/tabs/tabConfiguracoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await ThemeManager.initialise();
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  final themeDefault = "theme_1"; // salva no banco para depois pegar ao iniciar o app
  @override
  Widget build(BuildContext context) {

    var selectTheme = ThemeSetup();
    return BlocProvider(
      blocs: [
        Bloc((i) {

        }),
      ],
      dependencies: [],
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        defaultThemeId: themeDefault,
        themes: selectTheme.getThemes(),
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeProvider.themeOf(themeContext).data,
              title: AppLocalizations.of(context)!.app_title,
              initialRoute: "/splashscreen",
             routes: {
                "/": (_) => const Home(),
                "/splashscreen": (BuildContext context) =>Splashscreen(),
                "/home": (BuildContext context) => Home(),
                "/recuperar_senha": (BuildContext context) => RecuperarSenha(),
                "/configuracao": (BuildContext context) =>  TabConfiguracoes(),
              },
            ),
          ),
        ),
      ),
    );
  }

}
