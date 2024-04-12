import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_meta_data.dart';


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
    String path = join(databasesPath, nomeBanco);
    var client = await openDatabase(path, version: version);

    await client.execute(
      "CREATE TABLE IF NOT EXISTS $tableMyKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPrivateKey TEXT NOT NULL, $columnPublicKey TEXT NOT NULL)");
    await client.execute(
      "CREATE TABLE IF NOT EXISTS $tableMyKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPrivateKey TEXT NOT NULL, $columnPublicKey TEXT NOT NULL)");
    await client.execute(
      "CREATE TABLE IF NOT EXISTS $tableOtherKeys(id INTEGER PRIMARY KEY, $columnOtherName TEXT UNIQUE, $columnPublicKey TEXT)");

    return client;
  }

  void _onCreate(Database dba, int newVersion) async {
    Database? dbclient =  await db;

    await dbclient?.execute(
      "CREATE TABLE $tableMyKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPrivateKey TEXT NOT NULL, $columnPublicKey TEXT NOT NULL)");
    await dbclient?.execute(
      "CREATE TABLE $tableOtherKeys(id INTEGER PRIMARY KEY, $columnOtherName TEXT UNIQUE, $columnPublicKey TEXT)");
  }

  Future<List<String>?> getTables() async {
  Database? dbClient = await db;// Suponha que você já tenha uma referência para o banco de dados

  final List<Map<String, dynamic>>? tables = await dbClient?.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name!='android_metadata' AND name!='sqlite_sequence';");

  return tables?.map((Map<String, dynamic> table) => table['name'] as String).toList();
}

}
