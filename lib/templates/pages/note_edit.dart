


import 'dart:convert';
import 'dart:io';
import 'package:app_diario/bloc/blocNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NoteEdit extends StatelessWidget {

   var note;
   var _jsonAnotacao;
   var _textTitulo;
   var _humor;
   var _id;
   QuillController _textAreaController = QuillController.basic();

   //QuillController _textAreaController = QuillController.basic();
   NoteEdit({Key? key, this.note}) {
     _jsonAnotacao = jsonDecode(this.note['anotacao']);
     _textTitulo = TextEditingController(text: this.note['titulo']);// this.note['titulo'];
     _humor = this.note['humor'];
     _id = this.note['id'];
     print(this.note);
   //  _textAreaController = Document.fromJson(_jsonAnotacao);

     _textAreaController = QuillController(
          document: Document.fromJson(_jsonAnotacao),
          selection: const TextSelection.collapsed(offset: 0)
      );


   }
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    print(note);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Edit Note',
        ),
        actions: [
          IconButton(
            onPressed: () {
              var isText = _textAreaController.document.isEmpty();
              if (!isText) {
                var blocNote = BlocNote();

                print(_textTitulo.text);
                print(_id);
                print(_textAreaController.document.toDelta().toJson());
               var response =  blocNote.saveBlocNote(_id,jsonEncode(_textAreaController.document.toDelta().toJson()),_humor,_textTitulo.text);
              response.then((data){
                  print("edição da nota");
                  print(data);
                //  _textAreaController.clear();
                //  _textTitulo.clear();
                });


              }
            },
            icon: const Icon(Icons.note_add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                //  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _textTitulo,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        // icon: Icon(Icons.person),
                        hintText: 'Digite tiutlo',
                      )

                  ),
                ),
                Expanded(
                  child: QuillEditor(
                    controller: _textAreaController,
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: _focusNode,
                    autoFocus: true,
                    readOnly: false,
                    expands: false,
                    padding: EdgeInsets.zero,
                  //  multiRowsDisplay: false,
               //   showAlignmentButtons: true,
                    //  embedBuilders: FlutterQuillEmbeds.builders(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QuillToolbar.basic(
                   controller: _textAreaController,
                   onImagePickCallback: _onImagePickCallback,
                   onVideoPickCallback: _onVideoPickCallback,
                    // filePickImpl: openFileSystemPickerForDesktop,
                    // uncomment to provide a custom "pick from" dialog.
                    //  mediaPickSettingSelector: _selectMediaPickSetting,
                    // uncomment to provide a custom "pick from" dialog.
                    // cameraPickSettingSelector: _selectCameraPickSetting,
                    multiRowsDisplay: false,
                    showAlignmentButtons: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

   Future<String?> _onImagePickCallback(File file) async {
     final appDocDir = await getApplicationDocumentsDirectory();
     final copiedFile =  await file.copy('${appDocDir.path}/}');
     return copiedFile.path.toString();
   }
   Future<String> _onVideoPickCallback(File file) async {

     final appDocDir = await getApplicationDocumentsDirectory();
     final copiedFile =
     await file.copy('${appDocDir.path}/');
     return copiedFile.path.toString();
   }


}
