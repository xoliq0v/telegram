import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class GetUserUseCase{

  Future<Result<User>> get(int id);

}