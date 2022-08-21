import 'dart:convert';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class TabNote extends StatefulWidget {
  const TabNote({Key? key}) : super(key: key);

  @override
  State<TabNote> createState() => _NoteState();
}

class _NoteState extends State<TabNote> {
  final QuillController _textAreaController = QuillController.basic();
  var humor ="";
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
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

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: QuillEditor(
                  controller: _textAreaController,
                  scrollController: ScrollController(),
                  scrollable: true,
                  readOnly: false,
                  padding: const EdgeInsets.all(8),
                  expands: false,
                  autoFocus: false,
                  focusNode: FocusNode(),
                  placeholder:
                      AppLocalizations.of(context)!.anotacao_placeholder,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillToolbar.basic(
                controller: _textAreaController,
                multiRowsDisplay: false,
                showAlignmentButtons: true,
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              var isText = _textAreaController.document.isEmpty();
              if (!isText) {

                _textAreaController.clear();
                var blocNote = BlocNote();
                blocNote.saveBlocNote(
                    jsonEncode(_textAreaController.document.toDelta().toJson()),
                    humor);
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
