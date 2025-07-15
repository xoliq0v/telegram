import 'package:core/src/utils/result.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/src/set_code_use_case.dart';

class SetCodeUseCaseImpl extends SetCodeUseCase {
  SetCodeUseCaseImpl(this._repository);


  final TelegramRepository _repository;

  @override
  Future<Result<void>> execute(String code) async{

    try{

      final result = await _repository.sendCode(code);

      if (result is Ok) {
        return Result.success(null);
      } else if (result is TdError) {
        return Result.failure(_mapErrorMessage(result));
      }
      return Result.failure('Unknown error occurred');
    }catch(e){
      return Result.failure(e.toString());
    }

  }


  String _mapErrorMessage(TdError error) {
    switch (error.code) {
      case 400:
        return 'Invalid phone number';
      case 429:
        return 'Too many requests. Please try again later';
      case 500:
        return 'Server error. Please try again';
      default:
        return error.message;
    }
  }

  @override
  Stream<AuthorizationState> get stream => _repository.authStream;


}