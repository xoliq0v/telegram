//@GeneratedMicroModule;UseCasePackageModule;package:use_case/src/di/init.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:repository/repository.dart' as _i585;
import 'package:use_case/src/di/init.dart' as _i854;
import 'package:use_case/src/load_chats_use_case.dart' as _i1071;
import 'package:use_case/src/send_phone_number_use_case.dart' as _i87;
import 'package:use_case/use_case.dart' as _i987;

class UseCasePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final useCaseModule = _$UseCaseModule();
    gh.lazySingleton<_i87.SendPhoneNumberUseCase>(() => useCaseModule
        .providePhoneNumberUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.SetCodeUseCase>(() =>
        useCaseModule.provideSetCodeUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.GetChatsUseCase>(() =>
        useCaseModule.provideGetChatsUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i1071.LoadChatsUseCase>(() =>
        useCaseModule.provideLoadChatUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.GetFileUseCase>(() =>
        useCaseModule.provideGetFileUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.DownloadFileUseCase>(() => useCaseModule
        .provideDownloadFileUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.GetMeUseCase>(() =>
        useCaseModule.provideGetMeUseCase(gh<_i585.TelegramRepository>()));
    gh.lazySingleton<_i987.GetUserUseCase>(
        () => useCaseModule.provideUserUseCase(gh<_i585.TelegramRepository>()));
  }
}

class _$UseCaseModule extends _i854.UseCaseModule {}
