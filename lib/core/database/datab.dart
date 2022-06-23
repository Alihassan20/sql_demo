import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ali.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''');

 //    batch.execute('''
 //  CREATE TABLE "student" (
 //    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
 //    "title" TEXT NOT NULL,
 //    "note" TEXT NOT NULL
 //  )
 // ''');
    await batch.commit();
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  deleteDatabaseDone() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ali.db');
    await deleteDatabase(path);
  }



// نفس ال read data بس الفرق اني بديلها اسم الجدول بس بدون الامر بتاع ال sql
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }



  // نفس ال inseart data بس الفرق اني بديلها اسم الجدول , القيم بس بدون الامر بتاع ال sql


  insert(String table,Map<String , Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table , values);
    return response;
  }



  update(String table,Map<String , Object?> values, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table , values , where: myWhere);
    return response;
  }

  delete(String table,String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: myWhere);
    return response;
  }

















}
