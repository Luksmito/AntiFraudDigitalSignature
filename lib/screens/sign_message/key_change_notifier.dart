import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';

class KeyChangeNotifier with ChangeNotifier {
  String _privateKeyText = '';
  String _publicKeyText = '';
  MyKey _keyPair = const MyKey();


  String getPrivateKey() {
    return _privateKeyText;
  }
  String getPublicKey() {
    return _publicKeyText;
  }
  MyKey get keyPair => _keyPair;


  void setkeys(MyKey keyPairSelected) {
    _privateKeyText = keyPair.privateKey;
    _publicKeyText = keyPair.publicKey;
    _keyPair = keyPairSelected;
    notifyListeners();
  }

}