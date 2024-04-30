// Add your own .env file with secrets and build the env.g.dart file using ENVied
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env')
final class Env {
  @EnviedField(varName: 'FDCAPI_KEY', obfuscate: true)
  // ignore: prefer_const_declarations
  static final String fdcApiKey = _Env.fdcApiKey;
}