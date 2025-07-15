import 'package:core/core.dart';
import 'package:repository/repository.dart';

mixin TelegramServiceHelper {

  static TelegramService getTelegramService(){
    return GetIt.I.get<TelegramService>();
  }

}