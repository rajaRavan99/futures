import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:stonesearch/Models/SearchModel.dart';

import '../Models/NewSearchModel.dart';

class DBHelper {
  static const _databaseName = "SearchManager.db";
  static const tableUser = "Search";

  service() async {
    List modelData = [];
    var url = "https://status.cfsys.xyz/rap.json";

    var res;
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      res = jsonDecode(response.body);
      print("APi DATA:**************");
      print(res);
      modelData = NewSearchModelList(res);
    }else{
      print("Internal Server Error");
    }

    var list = modelData.map((data) => SearchModel.fromJson(data)).toList();

    for (int i = 0; i < list.length; i++) {
      DBHelper.insertData(list[i]);
    }
  }

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, _databaseName),
        onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableUser (id INTEGER PRIMARY KEY, Shape TEXT,Clarity TEXT, Color TEXT, Fromcts TEXT, Tocts TEXT,price TEXT)',
      );
    }, version: 1);
  }
  static Future<int> insertData(
    SearchModel newData,
  ) async {
    final db = await DBHelper.database();
    final res = await db.insert('$tableUser', newData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('{adasdasdasdasas : $res}');

    return res;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM $tableUser');
    return list;
  }

  static Future<List<Map<String, dynamic>>> getPrice() async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> list =
    await db.rawQuery('SELECT * FROM $tableUser WHERE Shape = selectedShape AND Clarity = selectedClarity AND Color = selectedColor AND price BETWEEN Fromcts AND Tocts');
    print('asdasdasdasdas ${list}');
    return list;
  }

  // Future<List<SearchModel>> getAllEmployees() async {
  //   final db = await DBHelper.database();
  //   final res = await db.rawQuery("SELECT * FROM $tableUser");
  //   List<SearchModel> list =
  //       res.isNotEmpty ? res.map((c) => SearchModel.fromJson(c)).toList() : [];
  //   return list;
  // }

  static Future<void> update(String date, String time, int amount, String choice, String notes) async {
    final db = await DBHelper.database();
    // ignore: unused_local_variable
    await db.rawUpdate(
      'UPDATE $tableUser SET date = ?, time = ?, amount = ?, choice = ?,notes = ? WHERE amount = ?',
      [date, time, amount, choice, notes, amount],
    );
  }

  static Future<void> delete(String notes) async {
    print(notes);
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM $tableUser WHERE notes = ?', [notes]);
  }
}
