




import 'dart:convert';
import 'dart:ui';

import 'package:app_diario/class/json/noteToJson.dart';
import 'package:app_diario/sqLite/dbNote.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

import '../class/json/noteToJson.dart';

class BlocNote implements BlocBase{
  var db;
  final _anotacaoController = BehaviorSubject();

  Stream get anotacaoController => _anotacaoController.stream;



  BlocNote(){
    db =  DbNote();
    listaAnotacao();

  }


 saveBlocNote(id,dados, humor,textTitulo) async{
//  var db =  DbNote();
   try{
     var js = noteToJson(id, dados,humor,textTitulo);

     return  await db.save(js.toJson());
   }catch (_) {}
 }

 listaAnotacao()async{
   try{
     var response = await db.lista();
     List anotacoes =[];
     response.forEach((res){
        anotacoes.add(res);
      });
     _anotacaoController.add(anotacoes);
     return anotacoes;
   }catch (_) {}

 }
  listaFiltoDataAnotacao(data)async{

    try{
      var response = await db.listaFiltoData(data);
      List anotacoes =[];
      response.forEach((res){
        anotacoes.add(res);
      });
      _anotacaoController.add(anotacoes);

      return anotacoes;
    }catch (_) {}

  }

  listaAgrupadaData()async{

    try{
      var response = await db.listaAgrupadaData();
      List anotacoes =[];
      response.forEach((res){
        anotacoes.add(res);
      });
    //  _anotacaoController.add(anotacoes);
      return anotacoes;
    }catch (_) {}

  }
 deleteNote(id)async{
   try{
       var delete = await db.delete(id);

       delete.then((response){
       //  print('response');
       //  print(response);
         listaAnotacao();

       });


   }catch (_) {

   }
 }



  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose

  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}