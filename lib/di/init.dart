import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:app_bloc/app_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';
import 'package:repository/repository.dart';
// import 'package:feature_auth/feature_auth.dart';
// import 'package:feature_main/feature_main.dart';

import 'init.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    // ExternalModule(CorePackageModule),
    ExternalModule(NavigationPackageModule),
    ExternalModule(TelegramDatabaseLibPackageModule),
    // ExternalModule(DatabasePackageModule),
    // ExternalModule(NetworkPackageModule),
    // ExternalModule(MapServicePackageModule),
    // ExternalModule(FirebaseEcoPackageModule),
  ],
  externalPackageModulesAfter: [
    ExternalModule(RepositoryPackageModule),
    ExternalModule(UseCasePackageModule),
    ExternalModule(AppBlocPackageModule),
  ],
)
Future<GetIt> configInjection() {
  return getIt.init();
}