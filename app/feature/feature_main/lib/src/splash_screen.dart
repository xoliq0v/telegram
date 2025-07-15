import 'dart:async';

import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

@RoutePage()
class SplashScreen extends StatefulWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<TdConfigCubit>(
      create: (_) => AppBlocHelper.getTdConfigBloc(),
      child: this,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  late final TdLibListenerService _tdLibListenerService;
  late final StreamSubscription<AuthorizationState> _authSub;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _tdLibListenerService = TdServiceHelper.geTdService();

    _authSub = _tdLibListenerService.authStream.listen((state) {
      final constructor = state.getConstructor();
      logger.i(constructor);

      switch (constructor) {
        case AuthorizationStateWaitTdlibParameters.constructor:
          AppBlocHelper.getTdConfigBloc().set();
          break;
        case AuthorizationStateWaitPhoneNumber.constructor:
          if (mounted) {
            Future.microtask(() {
              if (mounted) {
                NavigationUtils.getAuthNavigation().navigatePhoneNumber();
              }
            });
          }
          break;
        case AuthorizationStateWaitCode.constructor:
          if (mounted) {
            Future.microtask(() {
              NavigationUtils.getAuthNavigation().navigateSetCode();
            });
          }
          break;
        case AuthorizationStateReady.constructor:
          if (mounted) {
            Future.microtask(() {
              if (mounted) {
                NavigationUtils.getMainNavigation().navigateMainPage();
              }
            });
          }
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(constructor)),
          );
      }
    });
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Icon(
          CupertinoIcons.chat_bubble_2,
          size: 150,
          color: Colors.blue,
        ),
      ),
    );
  }
}
