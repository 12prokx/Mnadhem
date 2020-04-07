import 'dart:io';
import 'package:path/path.dart';
// should install these
// refer description for more
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// the database helper class
class Databasehelper {
  // database name
  static final _databasename = "tass.db";
  static final _databaseversion = 3;

  // the table name
  static final table = "my_table";

  // column names
  static final columnID = 'id';
  static final columnTask = "task";
  static final columnDate = 'date';

  // a database
  static Database _database;

  // privateconstructor
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  // asking for a database
  Future<Database> get databse async {
    if (_database != null) return _database;

    // create a database if one doesn't exist
    _database = await _initDatabase();
    return _database;
  }

  // function to return a database
  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $columnTask TEXT NOT NULL,
        $columnDate TEXT
        
      )
      ''');
  }

  // functions to insert data
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  // function to query all the rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  // function to queryspecific
  Future<List<Map<String, dynamic>>> queryspecific(String x) async {
    Database db = await instance.databse;
    // var res = await db.query(table, where: "age < ?", whereArgs: [age]);
    var res = await db.rawQuery('SELECT * FROM my_table WHERE date=?', [x]);
    return res;
  }

  Future<int> getcount(String x) async {
    Database db = await instance.databse;
    // var res = await db.query(table, where: "age < ?", whereArgs: [age]);
    var xa =
        await db.rawQuery('SELECT COUNT(*) FROM my_table WHERE date=?', [x]);
    return xa.length;
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.databse;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> update(int id, int x) async {
    Database db = await instance.databse;
    var res = await db.update(table, {"line": x == 1 ? 2 : 1},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data

}
