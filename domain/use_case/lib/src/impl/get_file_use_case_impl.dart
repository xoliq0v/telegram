import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

class GetFileUseCaseImpl extends GetFileUseCase {
  GetFileUseCaseImpl(this._repository);

  final TelegramRepository _repository;

  @override
  Future<Result<File>> get({required int fileId}) async{
    try{
      final result = await _repository.getFile(fileId);

      if(result is File){
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