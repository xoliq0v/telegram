import 'dart:async';
import 'dart:io';

import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:core/core.dart';

part 'config_state.dart';
part 'td_config_cubit.freezed.dart';

class TdConfigCubit extends Cubit<ConfigState>{
  TdConfigCubit(
      this._setTdConfig
      ):super(const ConfigState.init());

  final SetTdConfig _setTdConfig;

  Future<void> set() async{
    emit(const ConfigState.loading());

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDownloadDir = await getDownloadsDirectory();
    final deviceInfo = DeviceInfoPlugin();
    late final AndroidDeviceInfo androidInfo;

    if(Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }

    final result = await _setTdConfig.set(
        SetTdlibParameters(
            useTestDc: false,
            databaseDirectory: appDocDir.path,
            filesDirectory: appDownloadDir?.path ?? appDocDir.path,
            databaseEncryptionKey: Env.encryptCode,
            useFileDatabase: true,
            useChatInfoDatabase: true,
            useMessageDatabase: true,
            useSecretChats: true,
            apiId: Env.instance.apiId,
            apiHash: Env.instance.apiHash,
            systemLanguageCode: 'en-En',
            deviceModel: androidInfo.model,
            systemVersion: androidInfo.version.codename,
            applicationVersion: '1.0.0-beta'
        )
    );
    if(result is Ok){

      emit(const ConfigState.success());

    }else if(result is TdError){

      emit(ConfigState.error(result.message));

    }else {

      emit(const ConfigState.error('unknown'));

    }

  }

}