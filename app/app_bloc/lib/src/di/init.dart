import 'dart:async';

import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

import '../bloc/user/user_bloc.dart';

@module
abstract class AppBlocModule{

  TdConfigCubit provideTdConfigCubit(
      SetTdConfig setTdConfig
      ){
    return TdConfigCubit(setTdConfig);
  }

  ConnectionCubit provideConnectionCubit(
      TelegramRepository repo
      ){
    return ConnectionCubit(repo);
  }

  PhoneNumberCubit providePhoneNumberBloc(
      SendPhoneNumberUseCase sendPhoneNumber
      ){
    return PhoneNumberCubit(sendPhoneNumber);
  }

  VerificationCubit provideVerificationCubit(
      SetCodeUseCase setCodeUseCase
      ){
    return VerificationCubit(setCodeUseCase);
  }

  MainChatsBloc provideMainChatsBloc(
      GetChatsUseCase chatsUseCase,
      LoadChatsUseCase loadChatsUseCase
      ){
    return MainChatsBloc(chatsUseCase,loadChatsUseCase);
  }

  AvatarCubit provideAvatarCubit(
      GetFileUseCase getFileUseCase,
      DownloadFileUseCase downloadFileUseCase
      ){
    return AvatarCubit(getFileUseCase,downloadFileUseCase);
  }

  MeCubit provideMeCubit(
      GetMeUseCase getMeUseCase,
      DownloadFileUseCase downloadUseCase,
      GetFileUseCase getFileUseCase
      ){
    return MeCubit(getMeUseCase,downloadUseCase,getFileUseCase);
  }

  static UserManagerCubit getUserManagerCubit(
      GetUserUseCase getUserUseCase,
      ){
    return UserManagerCubit(getUserUseCase);
  }
}

@InjectableInit.microPackage()
FutureOr<void> initMicroPackage() {}