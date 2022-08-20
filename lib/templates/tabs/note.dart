


import 'package:flutter/material.dart';

class TabNote extends StatefulWidget {
  const TabNote({Key? key}) : super(key: key);

  @override
  State<TabNote> createState() => _NoteState();
}

class _NoteState extends State<TabNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("TabNote"),
    );
  }
}
