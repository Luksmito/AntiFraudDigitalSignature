import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String tableMyKeys = 'MyKeys';
const String columnId = '_id';
const String columnName = 'name';
const String columnPrivateKey = 'privateKey';
const String columnPublicKey = 'publicKey';

class MyKey {
  int id = -1;
  String name = '';
  String privateKey = '';
  String publicKey = '';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnPrivateKey: privateKey,
      columnPublicKey: publicKey
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  MyKey();

  MyKey.fromMap(Map<String, Object?> map) {
    id = map[columnId] != null ? map[columnId] as int : -1;
    name = map[columnName] as String;
    privateKey = map[columnPrivateKey] as String;
    publicKey = map[columnPublicKey] as String;
  }
}

class MyKeysHelper {
  static final MyKeysHelper _instance = MyKeysHelper.internal();
  factory MyKeysHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  MyKeysHelper.internal();

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'keys.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableMyKeys(id INTEGER PRIMARY KEY, $columnName TEXT UNIQUE, $columnPrivateKey TEXT, $columnPublicKey TEXT)");
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database? dbClient = await db;
    return await dbClient?.insert(tableMyKeys, item) ?? -1; // Retorna -1 se dbClient for nulo
  }
  Future<List<Map<String, dynamic>>> getAllItems() async {
    Database? dbClient = await db;
    return await dbClient?.query(tableMyKeys) ?? [];
  }

  Future<int> updateItem(Map<String, dynamic> item) async {
    Database? dbClient = await db;
    return await dbClient?.update(tableMyKeys, item, where: "id = ?", whereArgs: [item["id"]]) ?? -1;
  }

  Future<int> deleteItem(int id) async {
    Database? dbClient = await db;
    return await dbClient?.delete(tableMyKeys, where: "id = ?", whereArgs: [id]) ?? -1;
  }

}


Future<void> deleteDatabaseFile() async {
  // Obtenha o diretório onde o banco de dados está armazenado
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'keys.db');
  
  // Verifique se o arquivo do banco de dados existe
  bool exists = await databaseExists(path);
  
  if (exists) {
    // Se o arquivo existir, exclua-o
    await deleteDatabase(path);
    print("Banco de dados excluído com sucesso.");
  } else {
    print("O banco de dados não existe.");
  }
}