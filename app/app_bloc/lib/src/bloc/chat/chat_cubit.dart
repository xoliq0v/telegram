import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdlib/td_api.dart';
import 'package:repository/repository.dart';

part 'chat_message_state.dart';

class ChatMessageCubit extends Cubit<ChatMessageState> {
  final TelegramService telegram = TelegramServiceHelper.getTelegramService();

  int chatId = 0;
  static const int _pageSize = 30;

  ChatMessageCubit() : super(const ChatMessageState(messages: [], isLoading: false));

  Future<void> initialize({required int chatId}) async {
    this.chatId = chatId;
    emit(state.copyWith(isLoading: true, messages: [], lastMessageId: null));
    await _loadMessages(fromMessageId: 0, append: false);
  }

  Future<TdObject> getMessage(MessageReplyTo reply)async{
    try{
      late TdObject result;
      if(reply is MessageReplyToMessage){
        result = await telegram.send(GetMessage(chatId: chatId, messageId: reply.messageId));
      }else if(reply is MessageReplyToStory){
        result = await telegram.send(GetStory(storyId: reply.storyId, storySenderChatId: chatId, onlyLocal: false));
      }
      return result;
    }catch(e){
      rethrow;
    }
  }
  
  Future<void> _loadMessages({
    required int fromMessageId,
    required bool append,
  }) async {
    // if (append && state.isLoadingMore) return;
    // if (!append && state.isLoading) return;
    //
    // if (append) {
    //   emit(state.copyWith(isLoadingMore: true));
    // } else {
    //   emit(state.copyWith(isLoading: true));
    // }

    try {
      final result = await telegram.send(GetChatHistory(
        chatId: chatId,
        fromMessageId: fromMessageId,
        offset: 0,
        limit: _pageSize,
        onlyLocal: false,
      ));




      if (result is! Messages || result.messages == null) {
        emit(state.copyWith(isLoading: false, isLoadingMore: false, hasMore: false));
        return;
      }

      if(result.totalCount == 1){
        _loadMessages(fromMessageId: fromMessageId, append: true);
      }


      final newMessages = result.messages!;
      if (newMessages.isEmpty) {
        emit(state.copyWith(isLoading: false, isLoadingMore: false, hasMore: false));
        return;
      }

      final combined = append
          ? [...state.messages, ...newMessages]
          : newMessages;

      // Duplicate'larni yo'qotish uchun map
      final dedupedMap = <int, Message>{};
      for (var msg in combined) {
        dedupedMap[msg.id] = msg;
      }

      final sorted = dedupedMap.values.toList()
        ..sort((a, b) => b.id.compareTo(a.id));

      emit(state.copyWith(
        messages: sorted,
        isLoading: false,
        isLoadingMore: false,
        hasMore: newMessages.length == _pageSize,
        lastMessageId: sorted.isNotEmpty ? sorted.last.id : null,
      ));
    } catch (e, st) {
      emit(state.copyWith(isLoading: false, isLoadingMore: false));
    }
  }

  void loadMore() {
    if (!state.hasMore || state.isLoadingMore || state.lastMessageId == null) return;

    _loadMessages(
      fromMessageId: state.lastMessageId!,
      append: true,
    );
  }

  void addMessage(Message message) {
    if (message.chatId != chatId) return;

    final updated = [message, ...state.messages];
    final deduped = {for (var m in updated) m.id: m}.values.toList()
      ..sort((a, b) => b.id.compareTo(a.id));

    emit(state.copyWith(messages: deduped));
  }

  void updateMessage(Message updatedMsg) {
    final idx = state.messages.indexWhere((m) => m.id == updatedMsg.id);
    if (idx != -1) {
      final updated = [...state.messages];
      updated[idx] = updatedMsg;
      emit(state.copyWith(messages: updated));
    }
  }

  void deleteMessage(int msgId) {
    final updated = state.messages.where((m) => m.id != msgId).toList();
    emit(state.copyWith(messages: updated));
  }
}