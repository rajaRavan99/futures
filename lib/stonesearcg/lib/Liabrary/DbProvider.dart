import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stonesearch/Models/NewSearchModel.dart';

class DbProvider{
  static const databaseName = "SearchManager.db";
  static const tableUser = "Search";

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = "${directory.path}memos.db"; //create path to database

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db,int version) async{
        await db.execute(
          """CREATE TABLE IF NOT EXISTS $tableUser(
          ID INTEGER PRIMARY KEY,
          Shape TEXT,
          Clarity TEXT,
          Color TEXT,
          Fromcts DOUBLE,
          Tocts DOUBLE,
          price TEXT);"""
        );
      }
    );
  }

  Future<int> insertData(NewSearchModel newData) async{
    final db = await init(); //open database
    final res = await db.rawInsert(
        "INSERT INTO $tableUser(ID, Shape, Clarity, Color, Fromcts, Tocts, price) VALUES('${newData.ID}', '${newData.Shape}', '${newData.Clarity}', '${newData.Color}', '${newData.Fromcts}', '${newData.Tocts}', '${newData.price}' )");
    return res;
  }

  Future<int> getCount()async{
    final db = await init(); //open database
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableUser'))??0;
    return count;
  }

  Future<List<NewSearchModel>> getData() async{
    final db = await init();
    final maps = await db.query("Search");
    return NewSearchModelList(maps);
  }

  deleteTable() async{
    final db = await init();
    await db.delete(tableUser);
  }
}