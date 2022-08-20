

import 'package:flutter/material.dart';

class TabAgenda extends StatefulWidget {
  const TabAgenda({Key? key}) : super(key: key);

  @override
  State<TabAgenda> createState() => _TabAgendaState();
}

class _TabAgendaState extends State<TabAgenda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("tab agenda"),
    );
  }
}
