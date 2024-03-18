import 'package:elliptic/elliptic.dart';
import 'keys.dart';

void main() {
  var chavePrivada = PrivateKey.fromHex(getP256(), '3977bf5c9cf0ece3c05093f46ca8c30928c245bef39b5699862fe13cf536c66e');
  var chavePublica = chavePrivada.publicKey;

  var assinatura = signMessage("teste", chavePrivada);
  print(assinatura.toCompactHex());
  print(verifySignature(assinatura, chavePublica, message: "teste"));
}