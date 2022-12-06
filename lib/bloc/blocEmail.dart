



import 'dart:ui';


import 'package:app_diario/class/json/emailToJson.dart';
import 'package:app_diario/sqLite/modelEmail.dart';
import 'package:bloc_pattern/bloc_pattern.dart';


class BlocEmail implements BlocBase{
  var db;


 // final _emailController = BehaviorSubject();

//  Stream get emailController => _emailController.stream;



  BlocEmail(){
    db =  ModelEmail();
   // var email =  db.getEmail();
   // _emailController.add(email);

  }
  saveEmail(id,email,status,code,pass)async{

    print(id);
    print(email);
    print(status);
    print(code);
    print(pass);

    try{
      var js = emailToJson(id, email,status,code,pass);
      return  await db.save(js.toJson());
    }catch (_) {}
  }

  getEmail()async{
    try{
      var data = await db.getEmail();
      return data;
   //   return  db.getEmail();
    }catch (_) {}

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