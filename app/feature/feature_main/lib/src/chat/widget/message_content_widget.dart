import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

import 'text_message_widget.dart';

class MessageContentWidget extends StatelessWidget {
  final Message message;
  final bool isOutgoing;

  const MessageContentWidget({
    super.key,
    required this.message,
    this.isOutgoing = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = message.content;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (content is MessageText) {
      return TextMessageWidget(message: content, isOutgoing: isOutgoing);
    }

    return Text(
      '[Unsupported message type]',
      style: TextStyle(
        fontSize: 15,
        color: isOutgoing
            ? (isDark ? Colors.white70 : Colors.blue[900])
            : Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
    );
  }
}