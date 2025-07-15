import 'package:feature_main/feature_main.dart';
import 'package:navigation/src/navigation/main_navigation.dart';
import 'package:tdlib/td_api.dart';

import '../../../navigation.dart';

class MainNavigationImpl extends MainNavigation {
  MainNavigationImpl(this.appRouter);

  final AppRouter appRouter;

  @override
  Future<void> navigateMainPage() {
    return appRouter.replaceAll([const MainRoute()]);
  }

  @override
  Future<void> navigateChatPage(Chat chat) {
    return appRouter.navigate(ChatRoute(chat: chat));
  }

}