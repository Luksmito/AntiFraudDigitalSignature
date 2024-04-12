import 'package:crypto_id/controllers/my_keys_controller.dart';

class KeysController {
  MyKeysHelper keysHelper;

  KeysController() : keysHelper = MyKeysHelper();

  Future<List<MyKey>> getAllKeysRegistered() async {
    var response = await keysHelper.getAllItems();
    var chaves = <MyKey>[];
    for (var element in response) {
      chaves.add(MyKey().fromMap(element));
    }
    return chaves;
  }

  

}