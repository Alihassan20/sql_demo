

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb{
  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await intialDb();
      return _db;
    }
    return _db;
  }


  intialDb() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ali.db');
    var myDb = await openDatabase(path, onCreate:_onCreate);
    return myDb;
  }



  _onCreate(Database db, int version)async{
    await db.execute(
        'CREATE TABLE notes (id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY, notes TEXT NOT NULL)');
    print("DATA BASE CRATED ===============================");
  }

//get
  readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
//post add

  insertData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
//Delete
  deleteData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
//put update
  updateData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response;
  }



}