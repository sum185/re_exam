import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'product.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE add_data (id INTEGER PRIMARY KEY AUTOINCREMENT,image TEXT,name TEXT,price TEXT)";
        db.execute(query);
      },
    );
  }

  void insertData({
    required String image,
    required String name,
    required String price,
    // String? path
  }) async {
    database = await checkDB();
    database!.insert("add_data", {
      "image": image, "name": name, "price": price,
      // "image": data
    });
  }


  Future<List<Map>> readData() async {
    database = await checkDB();
    String query = "SELECT * FROM add_data";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDB();
    database!.delete("add_data", where: "id =? ", whereArgs: [id]);
  }
}
