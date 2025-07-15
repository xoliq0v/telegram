import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:feature_main/src/chat/widget/reply_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

import 'message_content_widget.dart';

class UserMessageWidget extends StatefulWidget {
  final Message message;
  const UserMessageWidget({super.key, required this.message});

  @override
  State<UserMessageWidget> createState() => _UserMessageWidgetState();
}

class _UserMessageWidgetState extends State<UserMessageWidget> {
  final ValueNotifier<User?> user = ValueNotifier(null);
  late final UserManagerCubit _cubit;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _cubit = context.read<UserManagerCubit>();
    final user = await _cubit.getUser((widget.message.senderId as MessageSenderUser).userId);
    if (user != null) {
      this.user.value = user;
    }
  }

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final isOutgoing = widget.message.isOutgoing;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<UserManagerCubit, Map<int, User>>(
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: user,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User name for incoming messages
                  if (!isOutgoing && value != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 58, bottom: 2),
                      child: Text(
                        '${value.firstName} ${value.lastName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment:
                    isOutgoing ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isOutgoing)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AvatarWidget(
                            userId: (widget.message.senderId as MessageSenderUser).userId,
                            radius: 20,
                          ),
                        ),
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: isOutgoing
                                ? (isDark ? const Color(0xFF2B5278) : const Color(0xFFE1F5FE))
                                : (isDark ? const Color(0xFF2F2F2F) : const Color(0xFFFFFFFF)),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: isOutgoing
                                  ? const Radius.circular(18)
                                  : const Radius.circular(4),
                              bottomRight: isOutgoing
                                  ? const Radius.circular(4)
                                  : const Radius.circular(18),
                            ),
                          ),
                          child: IntrinsicWidth(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.message.replyTo != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: ReplyWidget(replyTo: widget.message.replyTo),
                                    ),
                                  MessageContentWidget(
                                    message: widget.message,
                                    isOutgoing: isOutgoing,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Spacer(),
                                      if (widget.message.editDate != 0)
                                        Text(
                                          'edited',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isOutgoing
                                                ? (isDark ? Colors.white70 : Colors.blue[700])
                                                : Colors.grey[600],
                                          ),
                                        ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _formatTime(widget.message.date),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isOutgoing
                                              ? (isDark ? Colors.white70 : Colors.blue[700])
                                              : Colors.grey[600],
                                        ),
                                      ),
                                      if (isOutgoing) ...[
                                        const SizedBox(width: 4),
                                        Icon(
                                          widget.message.sendingState
                                          is MessageSendingStatePending
                                              ? Icons.schedule
                                              : widget.message.sendingState
                                          is MessageSendingStateFailed
                                              ? Icons.error_outline
                                              : Icons.done_all,
                                          size: 16,
                                          color: widget.message.sendingState
                                          is MessageSendingStateFailed
                                              ? Colors.red
                                              : isOutgoing
                                              ? (isDark
                                              ? Colors.white70
                                              : Colors.blue[700])
                                              : Colors.grey[600],
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
