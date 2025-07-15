import 'package:tdlib/td_api.dart';

abstract class TelegramService {
  Future<void> connect();
  Future<void> disconnect();
  bool get isConnected;

  Stream<T> listen<T extends TdObject>();
  Future<T> send<T extends TdObject>(TdFunction function);
}
