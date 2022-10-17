


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../universal_ui.dart';
//import 'read_only_page.dart';





class NoteEdit extends StatefulWidget {

   var note;
   var _jsonAnotacao;
   var _textTitulo;
   var _humor;
   var _id;
   QuillController _textAreaController = QuillController.basic();
   QuillController? _controller;
   //QuillController _textAreaController = QuillController.basic();
   NoteEdit({Key? key, this.note}) {
     _jsonAnotacao = jsonDecode(this.note['anotacao']);
     _textTitulo = TextEditingController(text: this.note['titulo']);// this.note['titulo'];
     _humor = this.note['humor'];
     _id = this.note['id'];
   //  print(this.note);
   //  _textAreaController = Document.fromJson(_jsonAnotacao);

       _controller = QuillController(
           document: _jsonAnotacao, selection: const TextSelection.collapsed(offset: 0));

     _textAreaController = QuillController(
         document: Document.fromJson(_jsonAnotacao),
         selection: const TextSelection.collapsed(offset: 0)
     );



   }

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.grey.shade800,
        elevation: 0,
        centerTitle: false,
        title:  Text(
            AppLocalizations.of(context)!.edt_editando,
        ),
        actions: [
          IconButton(
            onPressed: () {
              var isText = widget._textAreaController.document.isEmpty();
              if (!isText) {
                var blocNote = BlocNote();

             //   print(_textTitulo.text);
             //   print(_id);
             //   print(_textAreaController.document.toDelta().toJson());
               var response =  blocNote.saveBlocNote(widget._id,jsonEncode(widget._textAreaController.document.toDelta().toJson()),widget._humor,widget._textTitulo.text);
              response.then((data){
                var alert = AlertSnackBar();
                alert.alertSnackBar(context, Colors.red,AppLocalizations.of(context)!.sucesso);
              //    print("edição da nota");
             //     print(data);
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
              /*  Container(
                //  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: widget._textTitulo,
                      decoration:const InputDecoration(
                        border: InputBorder.none,
                        // icon: Icon(Icons.person),
                        hintText: 'Digite tiutlo',
                      )

                  ),
                ),*/
                Expanded(
                  child: QuillEditor(
                    controller: widget._textAreaController,
                    scrollController: ScrollController(),

                    scrollable: true,
                    readOnly: false,
                    padding: const EdgeInsets.all(8),
                    expands: false,
                    autoFocus: true,

                    focusNode: FocusNode(),
                    embedBuilders: FlutterQuillEmbeds.builders(),
               //  multiRowsDisplay: false,
              //    showAlignmentButtons: true,
                    //  embedBuilders: FlutterQuillEmbeds.builders(),
                   //   embedBuilder: _buildEmbedBuilder(context, _textAreaController)
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QuillToolbar.basic(
                   controller: widget._textAreaController,
                 //  onImagePickCallback: _onImagePickCallback,
                 //  onVideoPickCallback: _onVideoPickCallback,
                    // filePickImpl: openFileSystemPickerForDesktop,
                    // uncomment to provide a custom "pick from" dialog.
                   //   mediaPickSettingSelector: _selectMediaPickSetting,
                    // uncomment to provide a custom "pick from" dialog.
                    // cameraPickSettingSelector: _selectCameraPickSetting,
                    multiRowsDisplay: false,
                    showAlignmentButtons: false,
                    embedButtons: FlutterQuillEmbeds.buttons(
                      // provide a callback to enable picking images from device.
                      // if omit, "image" button only allows adding images from url.
                      // same goes for videos.
                      onImagePickCallback: _onImagePickCallback,
                      onVideoPickCallback: _onVideoPickCallback,
                      // uncomment to provide a custom "pick from" dialog.
                      // mediaPickSettingSelector: _selectMediaPickSetting,
                      // uncomment to provide a custom "pick from" dialog.
                      // cameraPickSettingSelector: _selectCameraPickSetting,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  _buildEmbedBuilder(  BuildContext context, QuillController controller) {


}

   Future<String?> _onImagePickCallback(File file) async {
   // print(file);
     final appDocDir = await getApplicationDocumentsDirectory();
     final copiedFile =   await file.copy('${appDocDir.path}/${basename(file.path)}');
     return copiedFile.path.toString();
   }

   Future<String> _onVideoPickCallback(File file) async {

     final appDocDir = await getApplicationDocumentsDirectory();
     final copiedFile = await file.copy('${appDocDir.path}/${basename(file.path)}');
     return copiedFile.path.toString();
   }
}
