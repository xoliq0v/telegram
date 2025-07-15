import 'package:core/src/utils/result.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/download_file_use_case_impl.dart';

class DownloadFileUseCaseImpl extends DownloadFileUseCase {
  DownloadFileUseCaseImpl(this._repository);

  final TelegramRepository _repository;

  @override
  Future<Result<File>> download(
      {required int fileId,
      required int priority,
      required int offset,
      required int limit,
      required bool synchronous}) async{
    try{
      final result = await _repository.downloadFile(fileId: fileId, priority: priority, offset: offset, limit: limit, synchronous: synchronous);
      if(result is File){
        return Result.success(result);
      }else if(result is TdError){
        return Result.failure(result.message);
      }else {
        return Result.failure('error');
      }
    }catch(e){
      return Result.failure(e.toString());
    }
  }
}