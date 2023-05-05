import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app_flutter/models/todo_class_converter.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper dataBaseHelper = DataBaseHelper._();
  Database? db;
  String dbName = 'TodoDB';
  String tableName = 'todoTable';
  String id = 'id';
  String columnName = 'todos';
  String Time = 'time';

  void initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT ,$columnName TEXT ,$Time TEXT)';
        await db.execute(query);
        print('database Created');
      },
    );
  }

  void insertData({required String todo, required String time}) async {
    initDB();
    String query = 'INSERT INTO $tableName($columnName,$Time)VALUES(?,?)';
    List arguments = [
      todo,
      time,
    ];
    int? id = await db?.rawInsert(query, arguments);
    print(id);
  }

  Future<List<TodoObject>> fetchAllRecode() async {
    initDB();
    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<TodoObject> allData =
        data.map((e) => TodoObject.fromMap(data: e)).toList();
    print(allData);
    return allData;
  }
}
