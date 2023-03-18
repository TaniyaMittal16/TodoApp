import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/registermodel.dart';

class DBProvider {

  DBProvider._privateConstructor();

  static final DBProvider db = DBProvider._privateConstructor();
  static final columnName = "todo";

  static Database? _database;

  String? get table => null;

  getAllRegisterModels() async {
    final db = await database;
    var res = await db!.query("RegisterModel");
    List<RegisterModel> list = res.isNotEmpty ? res.map((c) =>
        RegisterModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<Database?> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE RegisterModel ("
              "user_name VARCHAR,"
              "user_age VARCHAR,"
              "user_city VARCHAR,"
              "mobile_number VARCHAR,"
              "user_email VARCHAR,"
              "user_password VARCHAR"
              ")");
        });
  }
  // Future<List<Map<String, dynamic>>> query() async{
  //   final db = await database;
  //   return await db!.query(table!);
  // }

  newRegisterModel(RegisterModel newRegisterModel) async {
    final db = await database;
    var res = await db!.insert("RegisterModel", newRegisterModel.toMap());
    return res;
  }

  deleteRegisterModel(int id) async {
    final db = await database;
    return db?.delete("RegisterModel", where: "id = ?", whereArgs: [id]);
  }
  Future<List<RegisterModel>> getAllRegisterModel() async {
    final db = await database;
    var res = await db!.query("RegisterModel");
    List<RegisterModel> list =
    res.isNotEmpty ? res.map((c) => RegisterModel.fromMap(c)).toList() : [];
    return list;
  }


}
