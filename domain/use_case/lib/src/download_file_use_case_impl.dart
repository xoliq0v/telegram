import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class DownloadFileUseCase {
  Future<Result<File>> download({required int fileId, required int priority, required int offset,required int limit,required bool synchronous});
}