

import 'package:app_diario/class/json/noteToJson.dart';
import 'package:app_diario/sqLite/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class DbNote{
  Future<Database?> get db => DbHelper.getInstance().db;
  Future<int> save(dados) async {
    var dbClient = await db;
    return  await dbClient!.insert('anotacoes', dados, conflictAlgorithm: ConflictAlgorithm.replace);
  }

}