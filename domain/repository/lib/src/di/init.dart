import 'dart:async';
import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/impl/td_service.dart';
import 'package:repository/src/impl/telegram_repo_impl.dart';
import 'package:tdlib/td_client.dart';

@module
abstract class RepositoryModule {

  @preResolve
  @lazySingleton
  Future<Client> provideTdClient() async{
    final Client client = Client.create();
    await client.initialize();
    return client;
  }

  @lazySingleton
  TelegramService provideTelegramService(Client client){
    return TdLibService(client);
  }

  @lazySingleton
  TelegramRepository provideTelegramRepo(TelegramService telegramService){
    return TelegramRepositoryImpl(telegramService);
  }
}

@InjectableInit.microPackage()
FutureOr<void> initMicroPackage() {}
