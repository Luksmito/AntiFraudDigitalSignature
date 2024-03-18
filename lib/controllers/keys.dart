import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; 

/*
  Gera o par de chaves privada e pública
*/
PrivateKey generateKeys() {
  var ec = getP256();
  var key = ec.generatePrivateKey();
  return key;
}



/*
  Assina a dada mensagem com a dada chave privada
*/
Signature signMessage(String message, PrivateKey key) {
  var msgBytes = utf8.encode(message);
  var hash = sha256.convert(msgBytes).bytes;
  return signature(key, hash);
}


/*
  Gera o Hash da mensagem padrão
*/
List<int> generateStandardHash() {
  return sha256.convert(utf8.encode("Standard")).bytes;
}

/*
  Gera uma assinatura padrão com a chave privada dada
*/
Signature generateStandardSignature(PrivateKey key) {
  var bytes = generateStandardHash();
  return signature(key, bytes);
}

/*
  Verifica se a assinatura está de acordo com a chave pública fornecida
  caso não seja fornecida uma mensagem a assinatura padrão será usada 
*/
bool verifySignature(Signature signature, PublicKey pub, {String message = ""}) {
  List<int> bytes;
  if (message == "") {
    bytes = generateStandardHash();
    
  } else {
    bytes = sha256.convert(utf8.encode(message)).bytes;
  }
  return verify(pub, bytes, signature);
}

