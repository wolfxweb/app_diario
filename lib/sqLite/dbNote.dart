

import 'package:app_diario/class/json/noteToJson.dart';
import 'package:app_diario/sqLite/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class DbNote{

  Future<Database?> get db => DbHelper.getInstance().db;

  Future<int> save(dados) async {
    var dbClient = await db;
    return  await dbClient!.insert('anotacoes', dados, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<dynamic>> lista() async {
    var date = DateTime.now();
    var data = date.toString().substring(0, 10);
    final dbClient = await db;
  //  List<dynamic> list = await dbClient!.rawQuery('select date(data_hora) as data_hora,id,anotacao,titulo,humor from anotacoes ORDER by data_hora DESC');
    List<dynamic> list = await dbClient!.rawQuery("select * from anotacoes WHERE data_hora Like '${'%$data%'}' ");
    return list;
  }
  Future<List<dynamic>> delete(id) async {
    final dbClient = await db;
    return await dbClient!.rawQuery('DELETE from anotacoes where id = $id ');
   // return await dbClient!.rawQuery("UPDATE anotacoes set data_hora = '${'2022-09-25 22:00:00'}' where id =${id}");
  }
  Future<List<dynamic>> listaAgrupadaData() async {
    final dbClient = await db;
    List<dynamic> list = await dbClient!.rawQuery('select date(data_hora) as data_hora from anotacoes GROUP BY data_hora ORDER by data_hora DESC');
    return list;
  }
  Future<List<dynamic>> listaFiltoData(data) async {
    final dbClient = await db;
    List<dynamic> list = await dbClient!.rawQuery("select * from anotacoes WHERE data_hora Like '${'%$data%'}' ");
    return list;
  }
/*
  select * from anotacoes WHERE data_hora Like '%2022-09-25%'
  UPDATE anotacoes set data_hora = '2022-09-24 22:00:00' where id =2
 */
}