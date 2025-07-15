import 'package:flutter/material.dart' hide ConnectionState;
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

class ConnectionWidget extends StatefulWidget {
  const ConnectionWidget({super.key});

  @override
  State<ConnectionWidget> createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: TdServiceHelper.geTdService().connectionStream,
        builder: (context,state){
          return Text(
            state.data?.getConstructor() == ConnectionStateReady.constructor ? 'Telegram'
                : state.data?.getConstructor() == ConnectionStateConnecting.constructor ? 'Connecting...'
                : state.data?.getConstructor() == ConnectionStateUpdating.constructor ? 'Updating...'
                : state.data?.getConstructor() == ConnectionStateWaitingForNetwork.constructor ? 'Waiting for Network...'
                : state.data?.getConstructor() == ConnectionStateConnectingToProxy.constructor ? 'Connecting to proxy...' : 'Telegram',
            style: Theme.of(context).textTheme.titleLarge,
          );
        }
    );
  }
}