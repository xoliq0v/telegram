import 'package:tdlib/src/api/object.dart';
import 'package:tdlib/td_api.dart';
import 'package:tdlib/td_client.dart';
import 'package:telegram_database_lib/src/provider/set_code_provider.dart';

class SetCodeProviderImpl extends SetCodeProvider {
  SetCodeProviderImpl(this._client);

  final Client _client;

  @override
  Future<TdObject> set({required SendPhoneNumberCode code}) async{
    try{
      return await _client.send(code);
    }catch(e){
      rethrow;
    }
  }


}