import 'package:core/core.dart';

abstract class SendPhoneNumberUseCase {

  Future<Result<void>> execute(String phoneNumber);

}