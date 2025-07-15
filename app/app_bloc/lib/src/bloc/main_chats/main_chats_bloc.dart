import 'dart:async';
import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_chats_state.dart';

class MainChatsBloc extends Cubit<MainChatsState> {
  MainChatsBloc(this._getChatsUseCase, this._loadChatsUseCase)
      : super(const MainChatsState()) {
    fetch();
    _listenChatUpdates();
  }

  final GetChatsUseCase _getChatsUseCase;
  final LoadChatsUseCase _loadChatsUseCase;
  final Logger _logger = Logger();
  static const int _pageSize = 30;

  late final StreamSubscription<UpdateChatLastMessage> _chatUpdateSub;

  void _listenChatUpdates() {
    final td = TdServiceHelper.geTdService();
    _chatUpdateSub = td.streamLatestMessage.listen((e) async {
      try {
        final chat = await td.send(GetChat(chatId: e.chatId));
        if (chat is Chat) {
          onChatUpdated(chat);
        }
      } catch (err) {
        _logger.e('Error in updateChatLastMessage: $err');
      }
    });
  }

  Future<void> fetch() async {
    emit(state.copyWith(isInitialLoading: true));

    await _loadChatsUseCase.load(_pageSize, const ChatListMain());

    final result = await _getChatsUseCase.getChats(
      limit: _pageSize,
      type: const ChatListMain(),
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        chats: _sortChats(result.data),
        isInitialLoading: false,
        loadedAll: false,
      ));
    } else {
      emit(state.copyWith(
        error: result.error,
        isInitialLoading: false,
      ));
    }
  }

  Future<void> loadMore() async {
    if (state.isPaginationLoading || state.loadedAll) return;

    emit(state.copyWith(isPaginationLoading: true));

    try {
      await _loadChatsUseCase.load(_pageSize, const ChatListMain());

      final result = await _getChatsUseCase.getChats(
        limit: state.chats.length + _pageSize,
        type: const ChatListMain(),
      );

      if (result.isSuccess) {
        final newChats = result.data;
        final reachedEnd = newChats.length <= state.chats.length;

        emit(state.copyWith(
          chats: _sortChats(newChats),
          isPaginationLoading: false,
          loadedAll: reachedEnd,
        ));
      } else {
        emit(state.copyWith(
          errorPagination: result.error,
          isPaginationLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        errorPagination: e.toString(),
        isPaginationLoading: false,
      ));
    }
  }

  void onChatUpdated(Chat updatedChat) {
    final List<Chat> updatedChats = List.from(state.chats);
    final int existingIndex = updatedChats.indexWhere((c) => c.id == updatedChat.id);

    final bool isInMainList = updatedChat.positions.any((p) => p.list is ChatListMain);

    if (!isInMainList) {
      // Chat is no longer in Main list (e.g., deleted, archived)
      if (existingIndex != -1) {
        updatedChats.removeAt(existingIndex);
        emit(state.copyWith(chats: updatedChats));
      }
      return;
    }

    if (existingIndex != -1) {
      updatedChats[existingIndex] = updatedChat;
    } else {
      updatedChats.add(updatedChat);
    }

    emit(state.copyWith(chats: _sortChats(updatedChats)));
  }

  List<Chat> _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      final aOrder = _getOrder(a);
      final bOrder = _getOrder(b);
      return bOrder.compareTo(aOrder); // DESC
    });
    return chats;
  }

  int _getOrder(Chat chat) {
    final position = chat.positions.firstWhere(
          (p) => p.list is ChatListMain,
      orElse: () => ChatPosition(list: const ChatListMain(), order: 0,isPinned: false),
    );
    return position.order;
  }

  @override
  Future<void> close() async {
    await _chatUpdateSub.cancel();
    return super.close();
  }
}