import 'package:tdlib/td_api.dart';

abstract class MainNavigation {

  Future<void> navigateMainPage();

  Future<void> navigateChatPage(Chat chat);

}