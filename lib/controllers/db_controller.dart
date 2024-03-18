import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';





const String tableOtherKeys = 'OtherKeys';
const String columnName = 'name';
const String columnPublicKey = 'publicKey';
const String columnPrivateKey = 'privateKey';
const String tableMyKeys = 'MyKeys';

class DataBaseController {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'keys.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tableOtherKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPublicKey TEXT)");
    await db.execute(
      "CREATE TABLE $tableMyKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPublicKey TEXT)");
  }


}
