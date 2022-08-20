
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';


class ThemeSetup{
  getThemes() {

    return [
      AppTheme.light(id: "theme_1"), // This is standard light theme (id is default_light_theme)
      AppTheme.dark(id: "theme_2"), // This is standard dark theme (id is default_dark_theme)
      AppTheme(
        id: "theme_3",
        description: "Theme 3 ",
        data: ThemeData(  // Real theme data
          primaryColor: Colors.deepPurple,
          shadowColor: Colors.deepPurple,



          //    accentColor: Colors.red,
          backgroundColor: Colors.white,
          textTheme: const TextTheme(
            button: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.grey),
            headline2: TextStyle(color: Colors.grey),
            bodyText2: TextStyle(color: Colors.grey),
            subtitle1: TextStyle(color: Colors.grey),

          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,

          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple, // background (button) color
              onPrimary: Colors.white, // foreground (text) color
            ),
          ),
          brightness: Brightness.dark,
        ),

      ),
      AppTheme(
        id: "theme_4",
        description: "Theme 4 ",

        data: ThemeData(  // Real theme data
          primaryColor: Colors.deepPurple,
          //    accentColor: Colors.red,
         // backgroundColor: Colors.white,
          backgroundColor: Colors.blue,
          textTheme: const TextTheme(
            button: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.grey),
            headline2: TextStyle(color: Colors.grey),
            bodyText2: TextStyle(color: Colors.grey),
            subtitle1: TextStyle(color: Colors.grey),

          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,

          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple, // background (button) color
              onPrimary: Colors.white, // foreground (text) color
            ),
          ),
          brightness: Brightness.light,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            //selectedItemColor: Theme.of(context).deepPurple,
            backgroundColor: Colors.deepPurple,
          ),
         //   bottomNavigationBar



        ),

      ),
    ];
  }
}

