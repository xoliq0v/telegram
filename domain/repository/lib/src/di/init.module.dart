//@GeneratedMicroModule;RepositoryPackageModule;package:repository/src/di/init.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:repository/repository.dart' as _i585;
import 'package:repository/src/di/init.dart' as _i49;
import 'package:tdlib/td_client.dart' as _i248;

class RepositoryPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final repositoryModule = _$RepositoryModule();
    await gh.lazySingletonAsync<_i248.Client>(
      () => repositoryModule.provideTdClient(),
      preResolve: true,
    );
    gh.lazySingleton<_i585.TelegramService>(
        () => repositoryModule.provideTelegramService(gh<_i248.Client>()));
    gh.lazySingleton<_i585.TelegramRepository>(() =>
        repositoryModule.provideTelegramRepo(gh<_i585.TelegramService>()));
  }
}

class _$RepositoryModule extends _i49.RepositoryModule {}
