import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String tableOtherKeys = 'OtherKeys';
const String columnId = '_id';
const String columnName = 'name';
const String columnPublicKey = 'publicKey';

class OtherKeys {
  int id = -1;
  String name = '';
  String publicKey = '';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnPublicKey: publicKey
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  OtherKeys();

  OtherKeys.fromMap(Map<String, Object?> map) {
    id = map[columnId] != null ? map[columnId] as int : -1;
    name = map[columnName] as String;
    publicKey = map[columnPublicKey] as String;
  }
}

class OtherKeysHelper {
  static final OtherKeysHelper _instance = OtherKeysHelper.internal();
  factory OtherKeysHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  OtherKeysHelper.internal();

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'keys.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableOtherKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPublicKey TEXT)");
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database? dbClient = await db;
    return await dbClient?.insert(tableOtherKeys, item) ?? -1; // Retorna -1 se dbClient for nulo
  }
  Future<List<Map<String, dynamic>>> getAllItems() async {
    Database? dbClient = await db;
    return await dbClient?.query(tableOtherKeys) ?? [];
  }

  Future<int> updateItem(Map<String, dynamic> item) async {
    Database? dbClient = await db;
    return await dbClient?.update(tableOtherKeys, item, where: "id = ?", whereArgs: [item["id"]]) ?? -1;
  }

  Future<int> deleteItem(int id) async {
    Database? dbClient = await db;
    return await dbClient?.delete(tableOtherKeys, where: "id = ?", whereArgs: [id]) ?? -1;
  }

}
