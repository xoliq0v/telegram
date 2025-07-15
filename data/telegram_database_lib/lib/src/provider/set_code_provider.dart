import 'package:tdlib/td_api.dart';

abstract class SetCodeProvider{

  Future<TdObject> set({
    required SendPhoneNumberCode code
  });

}