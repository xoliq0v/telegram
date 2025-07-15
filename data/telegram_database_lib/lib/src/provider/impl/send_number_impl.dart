import 'package:tdlib/td_client.dart';
import 'package:tdlib/td_api.dart';

import '../../../telegram_database_lib.dart';

class SendPhoneNumberImpl extends SendPhoneNumber {
  SendPhoneNumberImpl(this.tdClient);

  final Client tdClient;

  @override
  Future<TdObject> send({required String phoneNumber}) async{
    try {
      return await tdClient.send(
        SetAuthenticationPhoneNumber(
          phoneNumber: phoneNumber,
          settings: const PhoneNumberAuthenticationSettings(
            allowFlashCall: false,
            allowSmsRetrieverApi: false,
            isCurrentPhoneNumber: false,
            allowMissedCall: false,
            hasUnknownPhoneNumber: false,
            authenticationTokens: [],
          ),
        ),
      );
    } catch (e) {
      return TdError(code: -1, message: e.toString());
    }
  }

}