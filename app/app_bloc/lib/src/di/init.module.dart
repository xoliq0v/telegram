//@GeneratedMicroModule;AppBlocPackageModule;package:app_bloc/src/di/init.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:app_bloc/app_bloc.dart' as _i3;
import 'package:app_bloc/src/di/init.dart' as _i7;
import 'package:injectable/injectable.dart' as _i1;
import 'package:repository/repository.dart' as _i5;
import 'package:telegram_database_lib/telegram_database_lib.dart' as _i6;
import 'package:use_case/use_case.dart' as _i4;

class AppBlocPackageModule extends _i1.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i2.FutureOr<void> init(_i1.GetItHelper gh) {
    final appBlocModule = _$AppBlocModule();
    gh.factory<_i3.MainChatsBloc>(() => appBlocModule.provideMainChatsBloc(
          gh<_i4.GetChatsUseCase>(),
          gh<_i4.LoadChatsUseCase>(),
        ));
    gh.factory<_i3.ConnectionCubit>(() =>
        appBlocModule.provideConnectionCubit(gh<_i5.TelegramRepository>()));
    gh.factory<_i3.VerificationCubit>(
        () => appBlocModule.provideVerificationCubit(gh<_i4.SetCodeUseCase>()));
    gh.factory<_i3.MeCubit>(() => appBlocModule.provideMeCubit(
          gh<_i4.GetMeUseCase>(),
          gh<_i4.DownloadFileUseCase>(),
          gh<_i4.GetFileUseCase>(),
        ));
    gh.factory<_i3.TdConfigCubit>(
        () => appBlocModule.provideTdConfigCubit(gh<_i6.SetTdConfig>()));
    gh.factory<_i3.UserManagerCubit>(
        () => _i3.AppBlocModule.getUserManagerCubit(gh<_i4.GetUserUseCase>()));
    gh.factory<_i3.AvatarCubit>(() => appBlocModule.provideAvatarCubit(
          gh<_i4.GetFileUseCase>(),
          gh<_i4.DownloadFileUseCase>(),
        ));
    gh.factory<_i3.PhoneNumberCubit>(() =>
        appBlocModule.providePhoneNumberBloc(gh<_i4.SendPhoneNumberUseCase>()));
  }
}

class _$AppBlocModule extends _i7.AppBlocModule {}
