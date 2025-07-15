import 'package:tdlib/td_api.dart';
import 'package:tdlib/td_client.dart';
import 'package:telegram_database_lib/src/provider/set_td_config.dart';


class SetTdConfigImpl extends SetTdConfig {
  SetTdConfigImpl(this.client);

  final Client client;

  @override
  Future<TdObject> set(SetTdlibParameters params) async {
    try{
      return await client.send(params);
    }catch(e){
      return TdError(code: -1, message: e.toString());
    }
  }
}