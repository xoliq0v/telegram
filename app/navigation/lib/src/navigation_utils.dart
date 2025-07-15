import 'package:core/core.dart';
import 'package:navigation/src/navigation/auth_navigation.dart';
import 'package:navigation/src/navigation/main_navigation.dart';

mixin NavigationUtils {

  static AuthNavigation getAuthNavigation(){
    return GetIt.I.get<AuthNavigation>();
  }

  static MainNavigation getMainNavigation(){
    return GetIt.I.get<MainNavigation>();
  }
}