import 'package:core/src/utils/result.dart';
import 'package:use_case/src/send_phone_number_use_case.dart';
import 'package:repository/repository.dart';
import 'package:tdlib/td_api.dart';

class SendPhoneNumberUseCaseImpl extends SendPhoneNumberUseCase{
  SendPhoneNumberUseCaseImpl(this._repository);

  final TelegramRepository _repository;

  @override
  Future<Result<void>> execute(String phoneNumber) async{
    try {
      if (!_isValidPhoneNumber(phoneNumber)) {
        return Result.failure('Invalid phone number format');
      }
      
      final result = await _repository.sendPhoneNumber(phoneNumber);
      
      if (result is Ok) {
        return Result.success(null);
      } else if (result is TdError) {
        return Result.failure(_mapErrorMessage(result));
      }
      
      return Result.failure('Unknown error occurred');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    return cleanNumber.startsWith('+') && 
           cleanNumber.length >= 8 && 
           cleanNumber.length <= 16;
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

}