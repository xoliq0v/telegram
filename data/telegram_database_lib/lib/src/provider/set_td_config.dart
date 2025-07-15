import 'package:tdlib/td_api.dart';

abstract class SetTdConfig {
  Future<TdObject> set(SetTdlibParameters param);
}