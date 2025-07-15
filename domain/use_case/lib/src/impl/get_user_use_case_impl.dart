import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/get_user_use_case.dart';

class GetUserUseCaseImpl extends GetUserUseCase {
  GetUserUseCaseImpl(this.repository);

  final TelegramRepository repository;

  @override
  Future<Result<User>> get(int id) async{
    try{
      final result = await repository.getUser(id);
      if(result is User){
        return Result.success(result);
      }else{
        return Result.failure((result as TdError).message);
      }
    }catch(e){
      return Result.failure(e.toString());
    }
  }
}