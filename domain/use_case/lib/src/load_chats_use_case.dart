import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class LoadChatsUseCase{

  Future<Result<List<Chat>>> load(
      int limit,
      ChatList type
      );

}