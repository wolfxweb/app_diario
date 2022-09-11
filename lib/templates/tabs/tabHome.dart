import 'package:app_diario/bloc/blocNote.dart';
import 'package:app_diario/templates/pages/note_edit.dart';
import 'package:app_diario/templates/read_only_page.dart';
import 'package:flutter/material.dart';

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
                  future:_listaNotas(),
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent)
                                            ),
                                            child: Column(
                                            //  crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[i]['data_hora']
                                                      .toString()
                                                      .substring(8, 10),
                                                  style: const TextStyle(
                                                    fontSize: 35,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data[i]['data_hora']
                                                              .toString()
                                                              .substring(5, 7) ==
                                                          '09'
                                                      ? 'Set'
                                                      : '',
                                                  style:
                                                      const TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(


                                              snapshot.data[i]['titulo'].toString(),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 18,),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                           // height: 75,
                                           // width: 50,

                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent)
                                            ),
                                            child: Column(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                                      //  return   NoteEdit(note: snapshot.data[i],);
                                                       return  ReadOnlyPage(snapshot.data[i]);
                                                      }));
                                                    },
                                                    icon: const Icon(Icons.edit)),
                                                IconButton(
                                                    onPressed: () {

                                                     var response =   blocNote.deleteNote(snapshot.data[i]['id']);
                                                     response.then((res){
                                                       Navigator.popAndPushNamed(context,'/');
                                                     });

                                                    },
                                                    icon: const Icon(Icons.delete)),
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

  _listaNotas(){

   return blocNote.listaAnotacao();
  }
}
