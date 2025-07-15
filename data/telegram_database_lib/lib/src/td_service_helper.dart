import 'package:core/core.dart';
import 'package:telegram_database_lib/src/service/lib_service.dart';

mixin TdServiceHelper {

  static TdLibListenerService geTdService(){
    return GetIt.I.get<TdLibListenerService>();
  }

}