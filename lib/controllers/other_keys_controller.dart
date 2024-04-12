import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_meta_data.dart';

class OtherKeys {
  int id = -1;
  String name = '';
  String publicKey = '';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnOtherName: name,
      columnPublicKey: publicKey
    };
    map[columnId] = id;
  
    return map;
  }

  OtherKeys();

  OtherKeys.fromMap(Map<String, Object?> map) {
    id = map["id"] != null ? map["id"] as int : -1;
    name = map[columnOtherName] != null ? map[columnOtherName]  as String : "";
    publicKey = map[columnPublicKey]!= null ? map[columnPublicKey]  as String : "";
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
    String path = join(databasesPath, nomeBanco);
    return await openDatabase(path, version: version);
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
