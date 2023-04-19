import 'dart:io';

import 'package:ecommerce_app/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper{
  static const dbName = "myDatabase.db";
  static const dbVersion = 5;
  static const dbTable = "myTable";
  static const columnId = "privateId";
  static const columnName = "name";
  static const id = "id";
  static const slug = "slug";
  static const title = "title";
  static const description = "description";
  static const price = "price";
  static const featured_image = "featured_image";
  static const status = "status";
  static const created_at = "created_at";

  static DatabaseHelper instance = DatabaseHelper();

  static Database? _database;
  Future<Database?> get database async{
    _database ??= await initDb();
    return _database;
  }
  initDb() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,dbName);
    return await openDatabase(path,version: dbVersion,onCreate: onCreate);
  }
  Future onCreate(Database db,int version) async{
    await db.execute('''
      CREATE TABLE $dbTable (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $id INTEGER,
        $slug TEXT,
        $title TEXT,
        $description TEXT,
        $price INTEGER,
        $featured_image TEXT,
        $status TEXT,
        $created_at TEXT
      )
    ''');
  }
  // insert method
  static insert(Product? product)async {
    final jsonProduct = product!.toJson();
    print("row=>${jsonProduct}");
    jsonProduct[columnName] = "123";
    Database? db = await instance.database;
  return await db?.insert(dbTable, jsonProduct,conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  // read method
  Future<List<Map<String,dynamic>>?> queryDatabase() async{
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

  // update Method
  Future<int?> updateDatabase(Map<String,dynamic> row) async{
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(dbTable,row,where: '$columnId = ?',whereArgs: [id]);
  }
  // delete Method
  Future<int?> deleteDatabase(int id) async{
    Database? db = await instance.database;
    return await db?.delete(dbTable,where: '$id = ?',whereArgs: [id]);
  }
}