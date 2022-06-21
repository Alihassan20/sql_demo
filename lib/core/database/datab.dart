

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
}