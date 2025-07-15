import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class GetFileUseCase {
  Future<Result<File>> get({required int fileId});
}