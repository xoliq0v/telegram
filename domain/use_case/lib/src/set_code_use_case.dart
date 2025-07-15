import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

abstract class SetCodeUseCase{

  Stream<AuthorizationState> get stream;

  Future<Result<void>> execute(String code);

}