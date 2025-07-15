import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class GetMeUseCase{

  Future<Result<User>> get();

}