import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

class TabNote extends StatefulWidget {
  const TabNote({Key? key}) : super(key: key);

  @override
  State<TabNote> createState() => _NoteState();
}

class _NoteState extends State<TabNote> {
  QuillController _textAreaController = QuillController.basic();
  var dateNow = DateTime.now().toLocalTime;

  @override
  Widget build(BuildContext context) {
    var dateNowFormatada = dateNow.format('MMMM dd y, h:mm:ss a');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             Container(
               child: ElevatedButton(
                  onPressed: (){

                  //  print(_textAreaController.document.toDelta().toJson());
                   // print(_textAreaController.document.toPlainText());

                  },
                 child: Icon(Icons.check),
               ),
             ),

          ],
        ),
      ),
    );
  }
}
