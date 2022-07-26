import 'package:myubuntu/models/models.dart';
import 'package:myubuntu/models/pass_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/directory.dart';
import '../models/models.dart';



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
    await db.execute("CREATE TABLE $dbname(${PassFields.id} TEXT PRIMARY KEY ,${PassFields.name} TEXT ,${PassFields.date} TEXT,${PassFields.code} TEXT )");
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
    final dbl = await instance.database;
    _database = null;
    dbl?.close();
  }
}