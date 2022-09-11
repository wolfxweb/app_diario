import 'dart:convert';
import 'dart:io';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

//ReadOnlyPage
/*
 _ReadOnlyPageState createState() => _ReadOnlyPageState();
}

class _ReadOnlyPageState extends State<ReadOnlyPage> {
 */
class TabNote extends StatefulWidget {
  const TabNote({Key? key}) : super(key: key);

  @override
  State<TabNote> createState() => _NoteState();
}

class _NoteState extends State<TabNote> {
  final QuillController _textAreaController = QuillController.basic();
  final _textTitulo = TextEditingController();
  var humor ="1";
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey.shade800,
        leading: IconButton(onPressed: (){
          Navigator.popAndPushNamed(context,'/');
        },icon:const Icon(Icons.arrow_back) ,),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Adicionando anotação',
        ),
        actions: [
          IconButton(
            onPressed: () {
              var isText = _textAreaController.document.isEmpty();
              if (!isText) {
                var blocNote = BlocNote();
                var response =  blocNote.saveBlocNote(null,jsonEncode(_textAreaController.document.toDelta().toJson()),humor,_textTitulo.text);
                response.then((data){
                  _textAreaController.clear();
                  _textTitulo.clear();
                });
              }
            },
            icon: const Icon(Icons.note_add),
          ),
        ],
      ),
      body: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                //  buildComoEstou(),
                  Container(
                    padding: const EdgeInsets.all(8.0),
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
                    child: Container(
                    //  padding: const EdgeInsets.all(8),
                      child: QuillEditor(
                        controller: _textAreaController,
                        scrollController: ScrollController(),
                        scrollable: true,
                        readOnly: false,
                        padding: const EdgeInsets.all(8),
                        expands: false,
                        autoFocus: false,
                        focusNode: FocusNode(),
                        placeholder:AppLocalizations.of(context)!.anotacao_placeholder,
                        embedBuilders: [
                          ...FlutterQuillEmbeds.builders(),
                        //  NotesEmbedBuilder(addEditNote: _addEditNote)
                        ],
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillToolbar.basic(
                      controller: _textAreaController,
                    //  onImagePickCallback: _onImagePickCallback,
                //      onVideoPickCallback: _onVideoPickCallback,
                      // filePickImpl: openFileSystemPickerForDesktop,
                      // uncomment to provide a custom "pick from" dialog.
                      //  mediaPickSettingSelector: _selectMediaPickSetting,
                      // uncomment to provide a custom "pick from" dialog.
                      // cameraPickSettingSelector: _selectCameraPickSetting,
                     // multiRowsDisplay: false,
                      showAlignmentButtons: true,
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
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                      child: Container(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildComoEstou() {
    return SizedBox(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal:16),
              child: Column(
                children: [
                   Row(
                    children:  [
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/img/img1.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            humor ="1";
                          });
                          print("1");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/img/img1.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            humor ="2";
                          });
                          print("2");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/img/img1.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            humor ="3";
                          });
                          print("3");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/img/img1.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            humor ="4";
                          });
                          print("4");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("assets/img/img1.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            humor ="5";
                          });
                          print("5");
                        },
                      ),
                      IconButton(onPressed: (){
                        var isText = _textAreaController.document.isEmpty();
                        if (!isText) {
                          var blocNote = BlocNote();

                          print(_textTitulo.text);
                          var response =  blocNote.saveBlocNote(null,jsonEncode(_textAreaController.document.toDelta().toJson()),humor,_textTitulo.text);
                          response.then((data){
                            print("data note linha 191");
                            print(data);
                            _textAreaController.clear();
                            _textTitulo.clear();
                          });
                        }
                      }, icon: Icon(Icons.check))

                    ],
                  ),
                ],
              ),
            ),
          );
  }


  Future<String?> _onImagePickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =  await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }
  Future<String> _onVideoPickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

}
