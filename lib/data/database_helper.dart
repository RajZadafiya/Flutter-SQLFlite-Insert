import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper()=> _instance;

  static Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async{
    io.Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path,"main.db");
    var ourdb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourdb;
  }

  void _onCreate(Database db,int version) async{
    await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY,username TEXT,password TEXT)");
    print("Table is creted...");
  }

  // insertion
  Future<int?> saveUser(User user) async{
     var dbClient = await db;
     var res = await dbClient?.insert("User", user.tomap());
     return res;
  }

  // deletion
  Future<int?> deleteUserTB(User user) async{
    var dbClient = await db;
    var res = await dbClient?.delete("User");
    return res;
  }
}
