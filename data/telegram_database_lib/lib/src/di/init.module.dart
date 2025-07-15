//@GeneratedMicroModule;TelegramDatabaseLibPackageModule;package:telegram_database_lib/src/di/init.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:tdlib/td_client.dart' as _i248;
import 'package:telegram_database_lib/src/di/init.dart' as _i291;
import 'package:telegram_database_lib/src/di/init_provider.dart' as _i113;
import 'package:telegram_database_lib/src/provider/set_code_provider.dart'
    as _i757;
import 'package:telegram_database_lib/telegram_database_lib.dart' as _i875;

class TelegramDatabaseLibPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final tdLibModule = _$TdLibModule();
    final tdLibProvidersModule = _$TdLibProvidersModule();
    gh.lazySingleton<_i875.TdLibListenerService>(
        () => tdLibModule.provideTdLibListenerService(gh<_i248.Client>()));
    gh.lazySingleton<_i875.SetTdConfig>(
        () => tdLibModule.provideTdConfig(gh<_i248.Client>()));
    gh.lazySingleton<_i757.SetCodeProvider>(
        () => tdLibModule.provideSetCode(gh<_i248.Client>()));
    gh.lazySingleton<_i875.SendPhoneNumber>(
        () => tdLibProvidersModule.provideSendPhoneNumber(gh<_i248.Client>()));
  }
}

class _$TdLibModule extends _i291.TdLibModule {}

class _$TdLibProvidersModule extends _i113.TdLibProvidersModule {}
