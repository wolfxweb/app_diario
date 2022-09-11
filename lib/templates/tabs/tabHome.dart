import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/templates/pages/note_edit.dart';
import 'package:app_diario/templates/read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var blocNote = BlocNote();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: _listaNotas(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print('snapshot.data');
                    print(snapshot.data);

                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    //  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        //  mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 85,
                                            width: 75,
                                            decoration: const BoxDecoration(
                                              //  border: Border.all(color: Colors.blueAccent),

                                            ),
                                            child: Column(
                                              //  crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildTextDiaAno(snapshot, i,8,10,32),
                                                buildTextMes(snapshot, i),
                                                buildTextDiaAno(snapshot, i,0,4,16),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data[i]['titulo']
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            // height: 75,
                                            // width: 50,

                                            decoration: const BoxDecoration(
                                                //  border: Border.all( color: Colors.blueAccent),
                                                ),
                                            child: Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                        //  return   NoteEdit(note: snapshot.data[i],);
                                                        return ReadOnlyPage(
                                                            snapshot.data[i]);
                                                      }));
                                                    },
                                                    icon:
                                                        const Icon(Icons.edit)),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text("Esta açõe e irevesivel."),
                                                            content: Text("Deseja continuar?"),
                                                            actions: [
                                                              // cancelButton,
                                                              // continueButton,
                                                              TextButton(
                                                                child:
                                                                    Text("Não"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    Text("Sim"),
                                                                onPressed: () {
                                                                  var response =
                                                                      blocNote.deleteNote(
                                                                          snapshot.data[i]
                                                                              [
                                                                              'id']);
                                                                  response.then(
                                                                      (res) {
                                                                    Navigator.popAndPushNamed(
                                                                        context,
                                                                        '/');
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          )),
    );
  }

  Text buildTextDiaAno(AsyncSnapshot<dynamic> snapshot, int i, int inicio, int fim, double sizeFont) {
    return Text(
      snapshot.data[i]['data_hora'].toString().substring(inicio, fim),
      style: TextStyle(
        fontSize: sizeFont,
      ),
    );
  }

  Text buildTextMes(AsyncSnapshot<dynamic> snapshot, int i) {
    var mesRef  = snapshot.data[i]['data_hora'].toString().substring(5, 7);
    var mes;
    if(mesRef == '01' ){
      mes = 'jan';
    }else if(mesRef == '02' ){
      mes = 'fev';
    }else if(mesRef == '03' ){
      mes = 'mar';
    }else if(mesRef == '04' ){
      mes = 'abr';
    }else if(mesRef == '05' ){
      mes = 'mai';
    }else if(mesRef == '06' ){
      mes = 'jun';
    }else if(mesRef == '07' ){
      mes = 'jul';
    }else if(mesRef == '08' ){
      mes = 'ago';
    }else if(mesRef == '09' ){
      mes = 'set';
    }else if(mesRef == '10' ){
      mes = 'ou';
    }else if(mesRef == '11' ){
      mes = 'nov';
    }else if(mesRef == '12' ){
      mes = 'dez';
    }
    return Text(mes,
      style: const TextStyle(fontSize: 18),
    );
  }

  _listaNotas() {
    return blocNote.listaAnotacao();
  }
}
