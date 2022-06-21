

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb{
  static Database? db;


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