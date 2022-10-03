



import 'package:app_diario/sqLite/dbHelper.dart';
import 'package:sqflite/sqflite.dart';


class ModelEmail{

  Future<Database?> get db => DbHelper.getInstance().db;

  Future<int> save(dados) async {
    print('dados');
    print(dados);
    var dbClient = await db;
    return  await dbClient!.insert('recuperacao_senha', dados, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<dynamic>> getEmail() async {
    final dbClient = await db;
    List<dynamic> list = await dbClient!.rawQuery("select * from recuperacao_senha limit 1");
    return list;
  }
}