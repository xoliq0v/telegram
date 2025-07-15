import 'package:core/core.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_main/feature_main.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen|Page,Route',
  modules: [FeatureMainModule,FeatureAuthModule]
)
class AppRouter extends _$AppRouter{

  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: cupertinoSlideTransition,
    durationInMilliseconds: 300,
    reverseDurationInMilliseconds: 300,
    opaque: true,
  );

  Widget cupertinoSlideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
      child: child,
    );
  }
  @override
  List<AutoRoute> get routes {
    return [
      /// FeatureMainModule
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: MainRoute.page,),
      AutoRoute(page: ChatRoute.page),

      /// FeatureAuthModule
      AutoRoute(page: PhoneNumberRoute.page),
      AutoRoute(page: CodeRoute.page),
      AutoRoute(page: PasswordRoute.page),
      AutoRoute(page: RegisterRoute.page),
    ];
  }

}