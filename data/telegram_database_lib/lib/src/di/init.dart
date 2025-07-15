import 'dart:async';

import 'package:core/core.dart';
import 'package:tdlib/td_client.dart';
import 'package:telegram_database_lib/src/provider/impl/send_number_impl.dart';
import 'package:telegram_database_lib/src/provider/impl/set_code_provider_impl.dart';
import 'package:telegram_database_lib/src/provider/set_code_provider.dart';

import '../../telegram_database_lib.dart';
import '../provider/impl/set_td_config_impl.dart';

@module
abstract class TdLibModule {



  @lazySingleton
  TdLibListenerService provideTdLibListenerService(Client client) {
    return TdLibListenerService(client);
  }

  @lazySingleton
  SetTdConfig provideTdConfig(Client client){
    return SetTdConfigImpl(client);
  }


  @lazySingleton
  SetCodeProvider provideSetCode(Client client){
    return SetCodeProviderImpl(client);
  }

}

@InjectableInit.microPackage()
FutureOr<void> initMicroPackage() {}