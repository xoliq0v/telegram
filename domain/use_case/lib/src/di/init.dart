import 'dart:async';

import 'package:core/core.dart';
import 'package:use_case/src/impl/download_file_use_case_impl.dart';
import 'package:use_case/src/impl/get_chats_use_case_impl.dart';
import 'package:use_case/src/impl/get_file_use_case_impl.dart';
import 'package:use_case/src/impl/get_me_use_case_impl.dart';
import 'package:use_case/src/impl/load_chats_use_case_impl.dart';
import 'package:use_case/src/impl/send_phone_number_use_case_impl.dart';
import 'package:use_case/src/impl/set_code_use_case_impl.dart';
import 'package:use_case/src/load_chats_use_case.dart';
import 'package:use_case/src/send_phone_number_use_case.dart';
import 'package:repository/repository.dart';

import '../../use_case.dart';
import '../get_chats_use_case.dart';
import '../impl/get_user_use_case_impl.dart';
import '../set_code_use_case.dart';

@module
abstract class UseCaseModule {

  @lazySingleton
  SendPhoneNumberUseCase providePhoneNumberUseCase(
    TelegramRepository repository
  ){
    return SendPhoneNumberUseCaseImpl(repository);
  }

  @lazySingleton
  SetCodeUseCase provideSetCodeUseCase(
      TelegramRepository repository
      ){
    return SetCodeUseCaseImpl(repository);
  }

  @lazySingleton
  GetChatsUseCase provideGetChatsUseCase(
      TelegramRepository repository
      ){
    return GetChatsUseCaseImpl(repository);
  }

  @lazySingleton
  LoadChatsUseCase provideLoadChatUseCase(
      TelegramRepository repository
      ){
    return LoadChatsUseCaseImpl(repository);
  }

  @lazySingleton
  GetFileUseCase provideGetFileUseCase(
      TelegramRepository repository
      ){
    return GetFileUseCaseImpl(repository);
  }

  @lazySingleton
  DownloadFileUseCase provideDownloadFileUseCase(
      TelegramRepository repository
      ){
    return DownloadFileUseCaseImpl(repository);
  }

  @lazySingleton
  GetMeUseCase provideGetMeUseCase(
      TelegramRepository repository
      ){
    return GetMeUseCaseImpl(repository);
  }

  @lazySingleton
  GetUserUseCase provideUserUseCase(
      TelegramRepository repository
      ){
    return GetUserUseCaseImpl(repository);
  }
}

@InjectableInit.microPackage()
FutureOr<void> initMicroPackage() {}