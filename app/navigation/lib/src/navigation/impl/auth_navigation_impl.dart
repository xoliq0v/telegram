import 'package:feature_auth/feature_auth.dart';
import 'package:navigation/src/navigation/auth_navigation.dart';

import '../../app_router.dart';

class AuthNavigationImpl extends AuthNavigation {
  AuthNavigationImpl(this.appRouter);

  final AppRouter appRouter;

  @override
  Future<void> navigatePhoneNumber() {
    return appRouter.replaceAll([const PhoneNumberRoute()]);
  }

  @override
  Future<void> navigateSetCode() {
    return appRouter.navigate(const CodeRoute());
  }


}