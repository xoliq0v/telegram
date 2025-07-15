import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/src/navigation/auth_navigation.dart';
import 'package:navigation/src/navigation/impl/auth_navigation_impl.dart';
import 'package:navigation/src/navigation/impl/main_navigation_impl.dart';
import 'package:navigation/src/navigation/main_navigation.dart';

import '../app_router.dart';

@module
abstract class NavigationModule{

  @singleton
  AppRouter provideAppRoute() {
    return AppRouter();
  }

  @lazySingleton
  AuthNavigation provideAuthNavigation(AppRouter appRouter){
    return AuthNavigationImpl(appRouter);
  }

  @lazySingleton
  MainNavigation provideMainNavigation(AppRouter appRouter){
    return MainNavigationImpl(appRouter);
  }
}

@InjectableInit.microPackage()
FutureOr<void> initMicroPackage() {}