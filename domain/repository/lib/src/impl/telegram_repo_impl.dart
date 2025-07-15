import 'package:tdlib/td_api.dart';
import 'package:logger/logger.dart';
import 'package:repository/repository.dart';

class TelegramRepositoryImpl implements TelegramRepository {
  final TelegramService _telegramService;
  final Logger _logger = Logger();
  
  TelegramRepositoryImpl(this._telegramService);
  
  @override
  Future<void> initialize() async {
    await _telegramService.connect();
  }
  
  @override
  Future<void> dispose() async {
    await _telegramService.disconnect();
  }
  
  @override
  Stream<AuthorizationState> get authStream => _telegramService
      .listen<UpdateAuthorizationState>()
      .map((update) => update.authorizationState);
  
  @override
  Stream<Message> get messageStream => _telegramService
      .listen<UpdateNewMessage>()
      .map((update) => update.message);
  
  @override
  Stream<Chat> get chatStream => _telegramService
      .listen<UpdateNewChat>()
      .map((update) => update.chat);


  @override
  Stream<UpdateFile> get updateFile => _telegramService
      .listen<UpdateFile>()
      .map((update) => update);

  @override
  Stream<ConnectionState> get connectionStream => _telegramService
      .listen<UpdateConnectionState>()
      .map((update) {
    _logger.i('Connection state update: ${update.state.getConstructor()}');
    return update.state;
  });
  
  @override
  Future<TdObject> sendPhoneNumber(String phoneNumber) async {
    try {
      return await _telegramService.send(
        SetAuthenticationPhoneNumber(
          phoneNumber: phoneNumber,
          settings: const PhoneNumberAuthenticationSettings(
            allowFlashCall: false,
            allowSmsRetrieverApi: true,
            isCurrentPhoneNumber: false,
            allowMissedCall: false,
            authenticationTokens: [],
            hasUnknownPhoneNumber: false,
          ),
        ),
      );
    } catch (e) {
      _logger.e('Failed to send phone number: $e');
      return TdError(code: -1, message: e.toString());
    }
  }
  
  @override
  Future<TdObject> sendCode(String code) async {
    try {
      return await _telegramService.send(
        CheckAuthenticationCode(code: code),
      );
    } catch (e) {
      _logger.e('Failed to send code: $e');
      return TdError(code: -1, message: e.toString());
    }
  }
  
  @override
  Future<TdObject> setConfig(SetTdlibParameters config) async {
    try {
      return await _telegramService.send(
        SetTdlibParameters(
          useTestDc: config.useTestDc,
          databaseDirectory: config.databaseDirectory,
          filesDirectory: config.filesDirectory,
          databaseEncryptionKey: config.databaseEncryptionKey,
          useFileDatabase: config.useFileDatabase,
          useChatInfoDatabase: config.useChatInfoDatabase,
          useMessageDatabase: config.useMessageDatabase,
          useSecretChats: config.useSecretChats,
          apiId: config.apiId,
          apiHash: config.apiHash,
          systemLanguageCode: config.systemLanguageCode,
          deviceModel: config.deviceModel,
          systemVersion: config.systemVersion,
          applicationVersion: config.applicationVersion,
        ),
      );
    } catch (e) {
      _logger.e('Failed to set config: $e');
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> getChats(int limit,ChatList type) async{
    try{
      _telegramService.send(const SetLogVerbosityLevel(newVerbosityLevel: 0));
      return await _telegramService.send(GetChats(
          limit: limit,
          chatList: type,

      ));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> getChat(int chatId) async{
    try{
      return await _telegramService.send(GetChat(chatId: chatId));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> loadChats(int limit,ChatList type) async{
    try{
      return await _telegramService.send(LoadChats(limit: limit,chatList: type));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> getFile(int fileId) async{
    try{
      return await _telegramService.send(GetFile(fileId: fileId));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> downloadFile({
      required int fileId,required  int priority,required  int offset,required  int limit,required  bool synchronous}) async{
    try{
      return await _telegramService.send(DownloadFile(fileId: fileId, priority: priority, offset: offset, limit: limit, synchronous: synchronous));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> getMe() async{
    try{
      return await _telegramService.send(const GetMe());
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }

  @override
  Future<TdObject> getUser(int id) async{
    try{
      return await _telegramService.send(GetUser(userId: id));
    }catch(e){
      _logger.e(e.toString());
      return TdError(code: -1, message: e.toString());
    }
  }
}