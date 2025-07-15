import 'package:core/core.dart';

@module
abstract class CoreModule{

  @singleton
  Env provideDevEnv() {
    return Env();
  }

  @singleton
  Logger provideLogger(){
    return Logger();
  }

}