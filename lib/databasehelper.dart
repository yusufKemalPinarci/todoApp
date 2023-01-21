import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "database.db";
  static final _databaseVersion = 2;

  static final table = 'my_table';
  static final table2 = 'sayi_table';
  static final columnId = 'id';

  static final columnName = 'name';
  static final columnText = 'text';
  static final columnsaat = 'saat';
  static final columntarih = 'tarih';
  static final columncomplete = 'completed';


  static final DatabaseHelper instance = DatabaseHelper();
  static Future<Database> _database = _initDatabase();

  // only have a single app-wide reference to the databas

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = (await _initDatabase()) as Future<Database>;
    return _database;
  }
  Future<int> update(Map<String, dynamic> row, int id) async {
    final db = await instance.database;
    row['completed'] = row['completed'] ? 1 : 0;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }



  // this opens the database (and creates it if it doesn't exist)
  static Future<Database> _initDatabase() async {
    print("_initDatabase method called");
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
      readOnly: false

    );
  }




  // SQL code to create the database table
  static Future<void> _onCreate(Database db, int version) async {
    await db.rawInsert(''' 
        CREATE TABLE $table ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NOT NULL, $columnText text NOT NULL,$columnsaat int default 00,$columntarih int default 00,$columncomplete bool default false)
    ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryTrue() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(table,where: '$columncomplete = true');
    print('queryAll: ${maps.length} rows');
    return maps;
  }
  Future<List<Map<String, dynamic>>> queryFalse() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(table,where: '$columncomplete = false');
    print('queryAll: ${maps.length} rows');
    return maps;
  }
}
