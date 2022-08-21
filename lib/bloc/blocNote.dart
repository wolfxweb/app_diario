




import 'dart:ui';

import 'package:app_diario/class/json/noteToJson.dart';
import 'package:app_diario/sqLite/dbNote.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class BlocNote implements BlocBase{





 saveBlocNote(dados, humor) async{
   var db =  DbNote();
   var js = noteToJson(null, dados , humor);
   var response =  await db.save(js.toJson());
   print("response saveBlocNote");
   print(response);
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