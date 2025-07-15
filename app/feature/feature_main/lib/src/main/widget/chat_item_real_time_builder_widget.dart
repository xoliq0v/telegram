import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

class ChatRealtimeBuilder extends StatelessWidget {
  final Chat initialChat;
  final Widget Function(Chat) builder;

  const ChatRealtimeBuilder({
    super.key,
    required this.initialChat,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Chat>(
      stream: ChatUpdatesManager()
          .chatStream
          .where((c) => c.id == initialChat.id)
          .distinct((prev, next) => prev == next),
      initialData: initialChat,
      builder: (context, snapshot) {
        final chat = snapshot.data ?? initialChat;
        return builder(chat);
      },
    );
  }
}