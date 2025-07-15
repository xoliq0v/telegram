import 'package:feature_main/src/chat/widget/user_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:tdlib/td_api.dart' hide Text;

import 'chat_message_widget.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMine;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    if(message.senderId.getConstructor() == MessageSenderUser.constructor){
      return UserMessageWidget(message: message);
    }else {
      return ChatMessageWidget(message: message,);
    }
  }
}