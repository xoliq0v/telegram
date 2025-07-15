import 'dart:isolate';

import 'package:core/src/utils/result.dart';
import 'package:repository/repository.dart';
import 'package:tdlib/src/api/objects/chat.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/load_chats_use_case.dart';

class LoadChatsUseCaseImpl extends LoadChatsUseCase {
  LoadChatsUseCaseImpl(this.repository);

  final TelegramRepository repository;


  @override
  Future<Result<List<Chat>>> load(int limit,ChatList type) async{
    try{
      final List<Chat> chatsList = [];
      final result = await repository.loadChats(limit, type);
      if(result is TdError){
        if(result.code == 404){
          return Result.failure(result.code.toString());
        }else{
          return Result.failure(result.message);
        }
      }else if(result is Chats) {
        for(var chatId in result.chatIds){
          try{
            final chat = await repository.getChat(chatId);
            if(chat is Chat){
              try{
                Isolate.run(() async{
                  // await repository.downloadFile(chat.photo?.small.id ?? 0,1,0,0,true);
                });
              }catch(e){
                continue;
              }
              chatsList.add(chat);
            }
          }catch(e){
            continue;
          }
        }
        return Result.success(chatsList);
      }
      return Result.failure('unknown');
    }catch(e){
      return Result.failure(e.toString());
    }
  }

}