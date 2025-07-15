import 'package:core/src/utils/result.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/get_chats_use_case.dart';


class GetChatsUseCaseImpl extends GetChatsUseCase {
  GetChatsUseCaseImpl(this._repository);
  final TelegramRepository _repository;

  @override
  Future<Result<List<Chat>>> getChats({
    required int limit,
    required ChatList type,
  }) async {
    final List<Chat> chatsList = [];

    try {
      final result = await _repository.getChats(
        limit,
        type,
        // offsetOrder,
        // offsetChatId,
      );

      if (result is Chats) {
        for (var chatId in result.chatIds) {
          try {
            final chat = await _repository.getChat(chatId);
            if (chat is Chat) {
              chatsList.add(chat);
            }
          } catch (_) {
            continue;
          }
        }
        return Result.success(chatsList);
      } else if (result is TdError) {
        return Result.failure(result.message);
      } else {
        return Result.failure('Unknown error!');
      }
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}