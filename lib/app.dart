import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:design_system/design_system.dart';
import 'di/init.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Telegram App',
      routerConfig: getIt<AppRouter>().config(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}