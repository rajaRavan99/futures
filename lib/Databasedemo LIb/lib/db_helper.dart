import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _databaseName = "db_demo.db";
  static const tableUser = "Users";

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, _databaseName),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE IF NOT EXISTS $tableUser (id INTEGER PRIMARY KEY, username TEXT, email TEXT, phone TEXT, age INTEGER)');
    }, version: 1);
  }

  static Future<void> insertData(
      String username, String email, int phone, int age) async {
    final db = await DBHelper.database();

    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $tableUser (username, email, phone, age) VALUES(?, ?, ?, ? )',
          // OR REPLACE
          [username, email, phone, age]);
      print(id1);
    });
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM $tableUser');
    return list;
  }

  // ignore: use_function_type_syntax_for_parameters
  static Future<void> update(
      String username, String email, int phone, int age) async {
    final db = await DBHelper.database();
    // ignore: unused_local_variable
    await db.rawUpdate(
        'UPDATE $tableUser SET username = ?, email = ? , phone = ? , age = ? WHERE email = ?',
        [username, email, phone, age, email]);
  }

  static Future<void> delete(String email) async {
    // ignore: avoid_print
    print(email);
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM $tableUser WHERE email = ?', [email]);
  }
}
