import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class GetChatsUseCase {
  Future<Result<List<Chat>>> getChats({
    required int limit,
    required ChatList type,
  });
}