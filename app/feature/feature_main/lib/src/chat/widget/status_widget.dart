import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

class StatusWidget extends StatefulWidget {
  final Chat chat;
  const StatusWidget({super.key,required this.chat});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatusCubit(widget.chat),
      child: BlocBuilder<StatusCubit, StatusState>(
        builder: (context, state) {
          return Text(
            state.statusText,
            style: Theme.of(context).textTheme.bodySmall,
          );
        },
      ),
    );
  }
}
