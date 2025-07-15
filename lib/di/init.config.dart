// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_bloc/app_bloc.dart' as _i995;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:navigation/navigation.dart' as _i1058;
import 'package:repository/repository.dart' as _i585;
import 'package:telegram_database_lib/telegram_database_lib.dart' as _i875;
import 'package:use_case/use_case.dart' as _i987;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i1058.NavigationPackageModule().init(gh);
    await _i875.TelegramDatabaseLibPackageModule().init(gh);
    await _i585.RepositoryPackageModule().init(gh);
    await _i987.UseCasePackageModule().init(gh);
    await _i995.AppBlocPackageModule().init(gh);
    return this;
  }
}
