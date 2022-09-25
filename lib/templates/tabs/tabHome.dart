import 'dart:convert';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/pages/note_edit.dart';
import 'package:app_diario/templates/read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';


class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var blocNote = BlocNote();
   DatePickerController _controller = DatePickerController();

  DateTime _selectedValue2 = DateTime.now();
  DateTime _selectedValue = DateTime.now();

  void initState() {
    _selectedValue = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

      return SingleChildScrollView(

      scrollDirection: Axis.vertical,
      child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //    crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //  buildData(),
              SizedBox(
                //  width: 20,
                height: 10,
                child:Container() ,
              ),
              Container(
                child:  DatePicker(
                 // DateTime.now(),
                  DateTime.now().subtract(const Duration(days: 4)),
                //  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,

                //  firstDate: DateTime(2019, 1),
                  onDateChange: (date) {
                    // New date selected
                    print(date);
                    setState(() {
                      _selectedValue2 = date;
                    });
                  },
                ),
              ),

              SizedBox(
              //  width: 20,
                height: 10,
                child:Container() ,
              ),
              StreamBuilder(
                stream: blocNote.anotacaoController,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                 // print(snapshot.data);
                  if(snapshot.hasData){
                    return builCardNote(snapshot);
                  }else{
                    return const CircularProgressIndicator();
                  }
                },
              ),

            ],
          )),
    );
  }

  FutureBuilder<dynamic> buildData() {
    return FutureBuilder(
               future: _listaNotas(),
                //    future:  blocNote.anotacaoController,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(
                    children: [
                 //   const   Text('data'),
                 //   const    Text('data'),

                      SizedBox(
                        height: 85,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              height: 85,
                              decoration:  BoxDecoration(
                                  color: Theme.of(context).primaryColor

                              ),
                              child: Column(
                               children: [
                                  buildTextDiaAno( snapshot, i, 8, 10, 32),
                                  buildTextMes(snapshot, i),
                                  buildTextDiaAno( snapshot, i, 0, 4, 16),
                                ],
                              ),
                            );
                          },
                        ),
                      ),




                      ],
                  )
                );
              } else {
                return const CircularProgressIndicator();
              }
            });
  }

  Column builCardNote(AsyncSnapshot<dynamic> snapshot) {
    return Column(
                  children: [
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            var anotacao =
                                jsonDecode(snapshot.data[i]['anotacao']);
                            return Card(
                              child: Container(
                                // padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      //  mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          height: 85,
                                          decoration: const BoxDecoration(
                                              //  border: Border.all(color: Colors.blueAccent),
                                              ),
                                          child: Column(
                                            //  crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              buildTextDiaAno( snapshot, i, 8, 10, 32),
                                              buildTextMes(snapshot, i),
                                              buildTextDiaAno( snapshot, i, 0, 4, 16),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              // mainAxisSize: MainAxisSize.max,
                                              child: TextField(
                                                controller: TextEditingController(
                                                    text: anotacao[0]['insert']),
                                                maxLines: 3,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            buildContainerDeleteEdit(
                                                context, snapshot, i),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
  }

  Container buildContainerDeleteEdit(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int i) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // height: 75,
      // width: 50,

      decoration: const BoxDecoration(
          //  border: Border.all( color: Colors.blueAccent),
          ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Esta açõe e irevesivel."),
                    content: Text("Deseja continuar?"),
                    actions: [
                      // cancelButton,
                      // continueButton,
                      TextButton(
                        child: Text("Não"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Sim"),
                        onPressed: () {
                          var response =
                              blocNote.deleteNote(snapshot.data[i]['id']);
                          response.then((res) {
                            var alert = AlertSnackBar();
                            alert.alertSnackBar(
                                context, Colors.green, 'Removido com sucesso');
                            Navigator.popAndPushNamed(context, '/');
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //  return   NoteEdit(note: snapshot.data[i],);
                  return ReadOnlyPage(snapshot.data[i]);
                }));
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }

  Text buildTextDiaAno(AsyncSnapshot<dynamic> snapshot, int i, int inicio,
      int fim, double sizeFont) {
    return Text(
      snapshot.data[i]['data_hora'].toString().substring(inicio, fim),
      style: TextStyle(
        fontSize: sizeFont,
      ),
    );
  }

  Text buildTextMes(AsyncSnapshot<dynamic> snapshot, int i) {
    var mesRef = snapshot.data[i]['data_hora'].toString().substring(5, 7);
    var mes;
    if (mesRef == '01') {
      mes = 'jan';
    } else if (mesRef == '02') {
      mes = 'fev';
    } else if (mesRef == '03') {
      mes = 'mar';
    } else if (mesRef == '04') {
      mes = 'abr';
    } else if (mesRef == '05') {
      mes = 'mai';
    } else if (mesRef == '06') {
      mes = 'jun';
    } else if (mesRef == '07') {
      mes = 'jul';
    } else if (mesRef == '08') {
      mes = 'ago';
    } else if (mesRef == '09') {
      mes = 'set';
    } else if (mesRef == '10') {
      mes = 'ou';
    } else if (mesRef == '11') {
      mes = 'nov';
    } else if (mesRef == '12') {
      mes = 'dez';
    }
    return Text(
      mes,
      style: const TextStyle(fontSize: 18),
    );
  }

  _listaNotas() {
    return blocNote.listaAgrupadaData();
  }
}
