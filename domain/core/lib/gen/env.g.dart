/// Generated file. Do not edit.
///
/// To regenerate, run: `dart run enven`
class Env {
  /// Override this instance to mock the environment.
  /// Example: `Env.instance = MockEnvData();`
  static EnvData instance = EnvData();

  static int get apiId => instance.apiId;
  static String get apiHash => instance.apiHash;
  static String get encryptCode => instance.encryptCode;
}

class EnvData {
  final int apiId = 17713907;

  final String apiHash = '77f8ec2b09c553caa48686613090da28';

  final String encryptCode = 'yRQXECxKMqRjIMZrsOhly1+tHw8BiUs2Hq5rQ+ZXAY0=';
}
