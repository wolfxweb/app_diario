import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class AppBarComponete {
  getAppBar(String title, context) {
    return AppBar(
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
            ThemeProvider.controllerOf(context).nextTheme();
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
