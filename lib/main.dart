import 'package:flutter/cupertino.dart';
import 'package:telegram/di/init.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configInjection();
  runApp(const App());
}