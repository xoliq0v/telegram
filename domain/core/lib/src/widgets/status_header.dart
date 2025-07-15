import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' as td;
import 'package:flutter/cupertino.dart';

class StatusHeader extends StatelessWidget{
  const StatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: BlocBuilder<ConnectionCubit,td.ConnectionState>(
            builder: (BuildContext context, state) {
              switch(state.getConstructor()){
                case td.ConnectionStateWaitingForNetwork.constructor:
                  return const Text('Waiting for network');
                case td.ConnectionStateConnecting.constructor:
                  return const Text('Connecting...');
                case td.ConnectionStateUpdating.constructor:
                  return const Text('Updating...');
                case td.ConnectionStateReady.constructor:
                  return const Text('Connected');
                default:
                  return const Text('');
              }
            },
          ),
        ),
      ),
    );
  }
}
