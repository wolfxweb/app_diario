import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtomNavidateBarComponent extends StatefulWidget {
  const ButtomNavidateBarComponent({Key? key}) : super(key: key);
  @override
  State<ButtomNavidateBarComponent> createState() =>
      _ButtomNavidateBarComponentState();
}
class _ButtomNavidateBarComponentState
    extends State<ButtomNavidateBarComponent> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      items: [
        TabItem(
          icon: Icons.auto_stories,
          title: AppLocalizations.of(context)!.menu_button_title_1,
        ),
        TabItem(
          icon: Icons.calendar_month,
          title: AppLocalizations.of(context)!.menu_button_title_2,
        ),
        TabItem(
          icon: Icons.add,
          title: AppLocalizations.of(context)!.menu_button_title_3,
        ),
        TabItem(
          icon: Icons.message,
          title: AppLocalizations.of(context)!.menu_button_title_4,
        ),
        TabItem(
          icon: Icons.settings,
          title: AppLocalizations.of(context)!.menu_button_title_5,
        ),
      ],
      //  initialActiveIndex: 2, //optional, default as 0
      onTap: (int i) {
        print('click index=$i');
      },
    );
  }
}
