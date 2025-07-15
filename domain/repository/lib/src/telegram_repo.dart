import 'package:tdlib/td_api.dart';

abstract class TelegramRepository {
  Future<void> initialize();
  Future<void> dispose();

  Stream<AuthorizationState> get authStream;
  Stream<Message> get messageStream;
  Stream<Chat> get chatStream;
  Stream<ConnectionState> get connectionStream;
  Stream<UpdateFile> get updateFile;

  Future<TdObject> sendPhoneNumber(String phoneNumber);
  Future<TdObject> sendCode(String code);
  Future<TdObject> setConfig(SetTdlibParameters config);
  Future<TdObject> getChats(int limit,ChatList type);
  Future<TdObject> loadChats(int limit,ChatList type);
  Future<TdObject> getChat(int chatId);
  Future<TdObject> getFile(int fileId);
  Future<TdObject> downloadFile({required int fileId,required int priority,required int offset,required int limit,required bool synchronous});
  Future<TdObject> getMe();
  Future<TdObject> getUser(int id);
}

