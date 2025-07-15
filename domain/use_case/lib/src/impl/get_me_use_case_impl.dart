import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/get_me_use_case.dart';

class GetMeUseCaseImpl extends GetMeUseCase {
  GetMeUseCaseImpl(this.repository);

  final TelegramRepository repository;

  @override
  Future<Result<User>> get() async{
    try{
      final result = await repository.getMe();
      if(result is User){
        return Result.success(result);
      }else if(result is TdError){
        return Result.failure(result.message);
      }else{
        return Result.failure('error');
      }
    }catch(e){
      return Result.failure(e.toString());
    }
  }
}