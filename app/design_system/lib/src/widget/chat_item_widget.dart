import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;
import 'package:core/core.dart';
import 'message_previews.dart';

class ChatItemWidget extends StatelessWidget {
  final Chat chat;
  final GestureTapCallback? onTap;

  const ChatItemWidget({super.key, required this.chat, this.onTap});

  bool _isLastMessageRead(Chat chat) =>
      chat.lastMessage != null &&
          chat.lastMessage!.isOutgoing == true &&
          chat.lastReadOutboxMessageId >= chat.lastMessage!.id;

  bool _shouldShowCheckIcon(Chat chat) =>
      chat.lastMessage?.isOutgoing == true;

  bool _shouldShowUnreadBadge(Chat chat) =>
      chat.unreadCount > 0 &&
          (chat.lastMessage?.isOutgoing == false || chat.lastMessage?.isOutgoing == null);

  bool _isMuted(Chat chat) =>
      (chat.notificationSettings.muteFor ?? 0) > 0;

  String get initial {
    final parts = chat.title.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else {
      return '?';
    }
  }

  int? get extractUserIdFromChat {
    if (chat.type is ChatTypePrivate) {
      return (chat.type as ChatTypePrivate).userId;
    } else if (chat.type is ChatTypeSecret) {
      return (chat.type as ChatTypeSecret).userId;
    }else if(chat.type is ChatTypeBasicGroup){
      return (chat.type as ChatTypeBasicGroup).basicGroupId;
    }else if(chat.type is ChatTypeSupergroup){
      return (chat.type as ChatTypeSupergroup).supergroupId;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPinned = chat.positions.any((pos) => pos.isPinned);
    final lastMessageDate = (chat.lastMessage?.date ?? 0).toLastDate();
    final isRead = _isLastMessageRead(chat);
    final shouldShowCheck = _shouldShowCheckIcon(chat);
    final isMuted = _isMuted(chat);

    return InkWell(
      onTap: onTap,
      child: Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RepaintBoundary(
                child: AvatarWidget(
                  userId: extractUserIdFromChat,
                  radius: 28,
                  fileId: chat.photo?.small.id,
                  miniThumb: chat.photo?.minithumbnail?.data,
                  initial: initial,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.title.isEmpty ? 'Deleted account' : chat.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).brightness == Brightness.dark ? AppTextStyles.darkChatTitle : AppTextStyles.lightChatTitle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            lastMessageDate,
                            style: Theme.of(context).brightness == Brightness.dark ? AppTextStyles.darkChatSubtitle : AppTextStyles.lightChatSubtitle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LastMessageWidget(message: chat.lastMessage),
                          ),
                          if (isPinned)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(Icons.push_pin_rounded, size: 18,),
                            ),
                          if (_shouldShowUnreadBadge(chat))
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: _UnreadBadge(
                                count: chat.unreadCount,
                                isMuted: isMuted,
                              ),
                            ),
                          if (shouldShowCheck)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(
                                isRead ? Icons.done_all : CupertinoIcons.checkmark_alt,
                                size: 18,
                                color: isRead ? Colors.blue : const Color(0xFF3B5165),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      height: 0,
                      color: Theme.of(context).colorScheme.surface,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  final int count;
  final bool isMuted;

  const _UnreadBadge({required this.count, required this.isMuted});

  @override
  Widget build(BuildContext context) {
    final String displayCount = count > 99 ? '99+' : '$count';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isMuted ? const Color(0xFF3B5165) : Colors.blue,
        shape: BoxShape.circle,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Center(
            child: Text(
              displayCount,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}