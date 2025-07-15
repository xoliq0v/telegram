
import 'package:core/core.dart';
import 'package:tdlib/td_client.dart';
import 'package:telegram_database_lib/src/provider/impl/set_td_config_impl.dart';

import '../../telegram_database_lib.dart';
import '../provider/impl/send_number_impl.dart';

@module
abstract class TdLibProvidersModule{

  @lazySingleton
  SendPhoneNumber provideSendPhoneNumber(Client tdClient){
    return SendPhoneNumberImpl(tdClient);
  }

}

