import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_meta_data.dart';

class MyKey {
  final int id;
  final String name;
  final String privateKey;
  final String publicKey;

  const MyKey({
    this.id = -1,
    this.name = '',
    this.privateKey = '',
    this.publicKey = '',
  });

  Map<String, Object?> toMap() {
    return {
      columnName: name,
      columnPrivateKey: privateKey,
      columnPublicKey: publicKey,
      columnId: id
    };
  }

  MyKey fromMap(Map<String, Object?> map) {
    
    return MyKey(
      id:  map["id"] != null ? map["id"] as int : -1,
      name: map[columnName] != null ? map[columnName]  as String : "",
      privateKey: map[columnPrivateKey]!= null ? map[columnPrivateKey]  as String : "",
      publicKey: map[columnPublicKey]!= null ? map[columnPublicKey]  as String : ""
    );
  
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
    String path = join(databasesPath, nomeBanco);
    return await openDatabase(path, version: version);
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
    return await dbClient?.update(tableMyKeys, item,
            where: "id = ?", whereArgs: [item["id"]]) ??
        -1;
  }

  Future<int> deleteItem(int id) async {
    Database? dbClient = await db;
    return await dbClient
            ?.delete(tableMyKeys, where: "id = ?", whereArgs: [id]) ??
        -1;
  }
}

Future<void> deleteDatabaseFile() async {
  // Obtenha o diretório onde o banco de dados está armazenado
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, nomeBanco);

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
