import 'package:core/core.dart';
import 'package:tdlib/td_api.dart';


abstract class SendPhoneNumber {
  Future<TdObject> send({
    required String phoneNumber,
  });
}