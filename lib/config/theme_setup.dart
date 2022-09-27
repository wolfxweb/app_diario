import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeSetup {
  getThemes() {
    return [
      AppTheme.light(
          id: "theme_1"), // This is standard light theme (id is default_light_theme)
      appThemeFucntion(
        "theme_2", //id thema
        "theme_2", // descrição do tema description
        Colors.deepPurple, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_5", //id thema
        "theme_5", // descrição do tema description
        Colors.pink, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_6", //id thema
        "theme_6", // descrição do tema description
        Colors.lightGreen, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_7", //id thema
        "theme_7", // descrição do tema description
        Colors.orange, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_8", //id thema
        "theme_8", // descrição do tema description
        Colors.grey, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_9", //id thema
        "theme_9", // descrição do tema description
        Colors.teal, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),
      appThemeFucntion(
        "theme_10", //id thema
        "theme_10", // descrição do tema description
        Colors.brown, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.black54, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.light, //brightness
      ),

      /* inicio do temas darck*/
      appThemeFucntion(
          "theme_4", //id thema
          "theme_4", // descrição do tema description
          Colors.deepPurple, // cor pimaria primaryColor
          Colors.blue, //backgroundColor
          Colors.white, //button
          Colors.white, // headline
          Colors.white,//onPrimary  cor texto botão
          Brightness.dark, //brightness
          ),
      appThemeFucntion(
        "theme_11", //id thema
        "theme_11", // descrição do tema description
        Colors.pink, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      appThemeFucntion(
        "theme_12", //id thema
        "theme_12", // descrição do tema description
        Colors.lightGreen, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      appThemeFucntion(
        "theme_13", //id thema
        "theme_13", // descrição do tema description
        Colors.orange, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      appThemeFucntion(
        "theme_14", //id thema
        "theme_14", // descrição do tema description
        Colors.grey, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      appThemeFucntion(
        "theme_15", //id thema
        "theme_15", // descrição do tema description
        Colors.teal, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white, // headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      appThemeFucntion(
        "theme_16", //id thema
        "theme_16", // descrição do tema description
        Colors.brown, // cor pimaria primaryColor
        Colors.blue, //backgroundColor
        Colors.white, //button
        Colors.white,// headline
        Colors.white,//onPrimary  cor texto botão
        Brightness.dark, //brightness
      ),
      AppTheme.dark(
          id: "theme_3"), // This is standard dark theme (id is default_dark_theme)
    ];
  }

  AppTheme appThemeFucntion(String id, String description, corPrimaria, corFundo, corButton,headline, corTexto,brightness) {
    return AppTheme(
      id: id,
      description: description,
      data: ThemeData(
        // Real theme data
        primaryColor: corPrimaria,
        // accentColor: Colors.red,
        backgroundColor:corFundo,
        textTheme: TextTheme(
          button: TextStyle(color: corButton ),
          headline1: TextStyle(color: headline),
          headline2: TextStyle(color: headline),
          bodyText2: TextStyle(color: headline),
          subtitle1: TextStyle(color: headline),
        ),
        appBarTheme:  AppBarTheme(
          backgroundColor: corPrimaria,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary:corPrimaria, // background (button) color
            onPrimary:corTexto , // foreground (text) color
          ),
        ),
        brightness: brightness,
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          backgroundColor: corPrimaria,
        ),
      ),
    );
  }
}
