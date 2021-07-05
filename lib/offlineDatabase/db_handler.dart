import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:the_national_dawn/Common/ClassList.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'eventvisitor.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE eventvisitor (id INTEGER PRIMARY KEY,Name TEXT,Company_Name TEXT,Email TEXT,Image TEXT,Phone TEXT UNIQUE)');
  }

  Future<Visitorclass> insertVisitor(Visitorclass visitor) async {
    var dbClient = await db;
    /*  try {
      visitor.id = await dbClient.insert('eventvisitor', visitor.toMap());
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "User already entere");
    }*/
    visitor.id = await dbClient.insert('eventvisitor', visitor.toMap());
    return visitor;
  }

  Future<List<Visitorclass>> getVisitors() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('eventvisitor',
        columns: ['id', 'Name', 'Company_Name', 'Email', 'Image', 'Phone']);
    print("Visitor Data-------" + maps.toString());
    List<Visitorclass> visitors = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        visitors.add(Visitorclass.fromMap(maps[i]));
      }
    }
    return visitors;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete('eventvisitor', where: 'id=?', whereArgs: [id]);
  }
}
