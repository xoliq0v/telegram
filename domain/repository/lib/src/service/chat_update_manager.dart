import 'dart:async';

import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:tdlib/td_api.dart';

class ChatUpdatesManager {
  static final ChatUpdatesManager _instance = ChatUpdatesManager._internal();
  factory ChatUpdatesManager() => _instance;
  ChatUpdatesManager._internal();

  final _chatController = BehaviorSubject<Chat>();
  Stream<Chat> get chatStream => _chatController.stream;

  final _chatCache = <int, Chat>{};
  late final TelegramService _telegramService;
  late final Logger _logger;
  late final List<StreamSubscription> _subs;

  void initialize(TelegramService service) {
    _telegramService = service;
    _logger = Logger();
    _subs = [
      service.listen<UpdateNewChat>().listen((e) {
        _logger.i('NewChat: ${e.chat.id}');
        _pushChat(e.chat);
      }),

      service.listen<UpdateChatLastMessage>().listen((e) async {
        _logger.i('UpdateChatLastMessage: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),

      service.listen<UpdateChatPosition>().listen((e) async {
        _logger.i('UpdateChatPosition: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),

      service.listen<UpdateChatReadInbox>().listen((e) async {
        _logger.i('UpdateChatReadInbox: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),

      service.listen<UpdateChatReadOutbox>().listen((e) async {
        _logger.i('UpdateChatReadOutbox: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),

      service.listen<UpdateChatPhoto>().listen((e) async {
        _logger.i('UpdateChatPhoto: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),

      service.listen<UpdateChatTitle>().listen((e) async {
        _logger.i('UpdateChatTitle: ${e.chatId}');
        await _fetchAndPush(e.chatId);
      }),
    ];
  }

  void _pushChat(Chat chat) {
    _chatCache[chat.id] = chat;
    _chatController.add(chat);
  }

  Future<void> _fetchAndPush(int chatId) async {
    try {
      final result = await _telegramService.send(GetChat(chatId: chatId));
      if (result is Chat) {
        _logger.i('Fetched chat: ${result.id}');
        _pushChat(result);
      } else {
        _logger.w('GetChat returned non-chat object: $result');
      }
    } catch (e, st) {
      _logger.e('Error in fetchAndPush: $e\n$st');
    }
  }

  void dispose() {
    for (var sub in _subs) {
      sub.cancel();
    }
    _chatController.close();
    _chatCache.clear();
  }
}