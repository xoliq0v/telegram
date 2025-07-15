import 'package:design_system/design_system.dart';
import 'package:feature_main/src/chat/widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

class ChatAppBar extends StatelessWidget {
  final Chat chat;
  const ChatAppBar({super.key,required this.chat});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      titleSpacing: 0,
      title: Row(
        children: [
          AvatarWidget(
            fileId: chat.photo?.small.id,
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat.title,style: Theme.of(context).textTheme.titleMedium,),
                StatusWidget(chat: chat)
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }
}