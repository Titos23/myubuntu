import 'package:myubuntu/models/models.dart';
import 'package:myubuntu/models/pass_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/directory.dart';
import '../models/models.dart';



// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database? _database;

//   Future<Database> get database async => _database ??= await initDatabase();

//   Future<Database> initDatabase() async {
//     String dbPath = join(appDirectory.path, 'pass.db');
//     return await openDatabase(
//       dbPath,
//       version: 1,
//       onCreate: _onCreate
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE DATABASE soldpass(
//         ${PassFields.id} INTEGER PRIMARY KEY NOT NULL,
//         ${PassFields.name} TEXT NOT NULL,
//         ${PassFields.color} TEXT,
//         ${PassFields.date} TEXT NOT NULL
//         );
//    ''');
//   }

//   Future<int> add(PassItem passItem) async {
//     Database db = await instance.database;
//     return db.insert('soldpass', passItem.toMap()) ;
//   }

//   Future<List<PassItem>> readAll() async {
//     final orderBy = '${PassFields.date} DESC';
//     final db = await instance.database;
//     final result = await db.query(
//       'soldpass',
//       columns: PassFields.values,
//       orderBy: orderBy,
//     );
    
//     return result.map((json) => PassItem.fromMap(json)).toList();
//   }
  
//   // Future<List<PassItem>> getPass() async {
//   //   Database db = await instance.database;
//   //   var pass = await db.query('pass', orderBy: 'id' );
//   //   List<PassItem> passList = pass.isNotEmpty
//   //     ? pass.map((e) => PassItem(id: 'id', name: 'name', color: color, date: 'date'))
//   // }
  
// }

class PassDatabase {
  static final PassDatabase instance = PassDatabase._init();

  static Database? _database;

  PassDatabase._init();
  String dbname = "Soldpass";


  Future<Database?> get database  async {
    
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    final dbPath = join(appDirectory.path, 'pass.db');
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("CREATE TABLE $dbname(${PassFields.id} TEXT PRIMARY KEY ,${PassFields.name} TEXT ,${PassFields.date} TEXT NOT NULL)");
  }

  Future<int> add(PassItem passItem) async {
    Database? db = await instance.database;
    return db!.insert('$dbname', passItem.toMap()) ;
    
  }

  Future<List<PassItem>> readAll() async {
    final orderBy = '${PassFields.date} DESC';
    final db = await instance.database;
    final result = await db!.query(
      '$dbname',
      columns: PassFields.values,
      orderBy: orderBy,
    );
    
    return result.map((json) => PassItem.fromMap(json)).toList();
  }
  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}