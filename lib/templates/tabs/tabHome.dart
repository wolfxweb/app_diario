import 'dart:convert';

import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/components/alert_snack.dart';
import 'package:app_diario/components/anuncio_banner.dart';
import 'package:app_diario/templates/home.dart';
import 'package:app_diario/templates/read_only_page.dart';
import 'package:app_diario/templates/tabs/tabConfiguracoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              AnuncioBanner(),
              SizedBox(
                //  width: 20,
                height: 10,
                child:Container() ,
              ),

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
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
                    title: Text(AppLocalizations.of(context)!.acao_ireversivel),
                    content: Text(AppLocalizations.of(context)!.deseja_continuar),
                    actions: [
                      // cancelButton,
                      // continueButton,

                      TextButton(
                        child: Text(AppLocalizations.of(context)!.btn_ativar_senha_false),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.btn_ativar_senha_true),
                        onPressed: () {
                          var response =
                              blocNote.deleteNote(snapshot.data[i]['id']);
                          response.then((res) {
                            var alert = AlertSnackBar();
                            alert.alertSnackBar(
                                context, Colors.green, AppLocalizations.of(context)!.sucesso);
                          //  Navigator.popAndPushNamed(context, '/home');

                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return   Home();
                            }));
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
              icon:  const Icon(Icons.edit,
               // color: Theme.of(context).primaryColor!='0xff673ab7'?Colors.white:Colors.green,
              ),
          ),
        ],
      ),
    );
  }
}
