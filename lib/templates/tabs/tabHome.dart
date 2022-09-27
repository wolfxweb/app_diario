import 'dart:convert';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/templates/pages/note_edit.dart';
import 'package:app_diario/templates/read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var blocNote = BlocNote();
  var dias = 4;
  var texto ='opa';
  late DateTime _selectedDate;

  void initState() {
    super.initState();
    _resetSelectedDate();
  }
  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                decoration: BoxDecoration(
                   color: Theme.of(context).primaryColor,
                   borderRadius: BorderRadius.circular(5),

                ),

                child: CalendarTimeline(
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020, 1, 1),
                  lastDate: DateTime.now().add(Duration(days: 365 * 1)),
                  onDateSelected: (date) {
                    blocNote.listaFiltoDataAnotacao(date.toString().substring(0, 10));
                    print(Theme.of(context).primaryColor);
                    setState(() {
                      _selectedDate = date;
                     // blocNote.listaFiltoDataAnotacao(date.toString().substring(0, 10));
                    });
                  },
                  leftMargin: 20,
                  monthColor: Colors.white,
                  dayColor:  Colors.white,
                  activeDayColor: Theme.of(context).primaryColor,
                  activeBackgroundDayColor:  Colors.white,
                  dotsColor: Theme.of(context).primaryColor,
              //    showYears: true,
                //  selectableDayPredicate: (date) => date.day != 23,
                 // locale: 'pt_ISO',
                )

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
  builCardNote(AsyncSnapshot<dynamic> snapshot) {
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *0.90,
                                              // mainAxisSize: MainAxisSize.max,
                                              child: TextField(
                                                controller: TextEditingController(
                                                    text: anotacao[0]['insert']),
                                                maxLines: 2,
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

  Container buildContainerDeleteEdit(BuildContext context, AsyncSnapshot<dynamic> snapshot, int i) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // height: 75,
      // width: 50,

      decoration: const BoxDecoration(
          //  border: Border.all( color: Colors.blueAccent),
          ),
      child: Row(
        children: [
          Text(snapshot.data[i]['data_hora'].toString().substring(0, 10)),
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
            icon: const Icon(Icons.delete,color: Colors.red,),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //  return   NoteEdit(note: snapshot.data[i],);
                  return ReadOnlyPage(snapshot.data[i]);
                }));
              },
              icon:  Icon(Icons.edit,
               // color: Theme.of(context).primaryColor!='0xff673ab7'?Colors.white:Colors.green,
              ),
          ),
        ],
      ),
    );
  }
/*
  Text buildTextDiaAno(AsyncSnapshot<dynamic> snapshot, int i, int inicio,
      int fim, double sizeFont) {
    return Text(
      snapshot.data[i]['data_hora'].toString().substring(inicio, fim),
      style: TextStyle(
        fontSize: sizeFont,
      ),
    );
  }
  */
/*
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
*/
  /*_listaNotas() {
    return blocNote.listaAgrupadaData();
  }
  */
}
