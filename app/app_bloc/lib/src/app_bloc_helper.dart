

import 'package:app_bloc/app_bloc.dart';
import 'package:app_bloc/src/bloc/user/user_bloc.dart';
import 'package:core/core.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

mixin AppBlocHelper {

  static TdConfigCubit getTdConfigBloc(){
    return GetIt.I.get<TdConfigCubit>();
  }

  static ConnectionCubit getConnectionCubit(){
    return GetIt.I.get<ConnectionCubit>();
  }

  static PhoneNumberCubit getPhoneNumberCubit(){
    return GetIt.I.get<PhoneNumberCubit>();
  }

  static VerificationCubit getVerificationCubit(){
    return GetIt.I.get<VerificationCubit>();
  }

  static MainChatsBloc getMainChatsBloc(){
    return GetIt.I.get<MainChatsBloc>();
  }

  static AvatarCubit getAvatarCubit(){
    return GetIt.I.get<AvatarCubit>();
  }

  static MeCubit getMeCubit(){
    return GetIt.I.get<MeCubit>();
  }

  static UserManagerCubit getUserManagerCubit(){
    return GetIt.I.get<UserManagerCubit>();
  }
}