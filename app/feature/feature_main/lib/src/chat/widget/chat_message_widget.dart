import 'package:app_bloc/app_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

import 'message_content_widget.dart';

class ChatMessageWidget extends StatefulWidget {
  final Message message;
  final bool isOutgoing;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.isOutgoing = false,
  });

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  User? _sender;
  bool _isLoadingUser = false;

  @override
  void initState() {
    super.initState();
    _loadSender();
  }

  Future<void> _loadSender() async {
    if (widget.isOutgoing) return;

    final senderId = _getSenderId();
    if (senderId == null) return;

    setState(() => _isLoadingUser = true);

    final userManager = AppBlocHelper.getUserManagerCubit();

    // Avval cache'dan tekshirish
    _sender = userManager.getCachedUser(senderId);
    if (_sender != null) {
      setState(() => _isLoadingUser = false);
      return;
    }

    // API'dan olish
    _sender = await userManager.getUser(senderId);
    if (mounted) {
      setState(() => _isLoadingUser = false);
    }
  }

  int? _getSenderId() {
    if (widget.message.senderId is MessageSenderUser) {
      return (widget.message.senderId as MessageSenderUser).userId;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final senderId = _getSenderId();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        mainAxisAlignment: widget.isOutgoing
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!widget.isOutgoing) ...[
            // Avatar for incoming messages
            // AvatarWidget(
            //   userId: senderId,
            //   fileId: _sender?.profilePhoto?.small?.id,
            //   miniThumb: _sender?.profilePhoto?.minithumbnail?.data,
            //   radius: 16,
            // ),
            const SizedBox(width: 8),
          ],

          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: widget.isOutgoing
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // Sender name for group chats
                  if (!widget.isOutgoing && _sender != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 4),
                      child: Text(
                        _getSenderName(_sender!),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getSenderColor(senderId ?? 0),
                        ),
                      ),
                    ),
                  ],

                  // Loading indicator for sender name
                  if (!widget.isOutgoing && _sender == null && _isLoadingUser) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 4),
                      child: Container(
                        height: 12,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],

                  // Message content
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 225, 254, 198),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: widget.isOutgoing ? const Radius.circular(15) : const Radius.circular(5),
                        bottomRight: widget.isOutgoing ? const Radius.circular(5) : const Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: MessageContentWidget(
                        message: widget.message,
                        isOutgoing: widget.isOutgoing,
                      ),
                    ),
                  ),

                  // Message info (time, status)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(widget.message.date),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (widget.isOutgoing) ...[
                          const SizedBox(width: 4),
                          Icon(
                            _getStatusIcon(widget.message),
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (widget.isOutgoing) ...[
            const SizedBox(width: 8),
            // Avatar for outgoing messages
            AvatarWidget(
              userId: senderId,
              radius: 16,
            ),
          ],
        ],
      ),
    );
  }

  String _getSenderName(User sender) {
    final firstName = sender.firstName.trim();
    final lastName = sender.lastName.trim();

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '$firstName $lastName';
    } else if (firstName.isNotEmpty) {
      return firstName;
    } else if (lastName.isNotEmpty) {
      return lastName;
    } else {
      return 'User ${sender.id}';
    }
  }

  Color _getSenderColor(int userId) {
    final colors = [
      Colors.red.shade600,
      Colors.green.shade600,
      Colors.blue.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
      Colors.teal.shade600,
      Colors.pink.shade600,
      Colors.indigo.shade600,
    ];
    return colors[userId.abs() % colors.length];
  }

  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  IconData _getStatusIcon(Message message) {
    // Message status logic
    if (message.sendingState == null) {
      // Message sent successfully
      return Icons.done_all; // You can check if it's read
    } else if (message.sendingState is MessageSendingStatePending) {
      return Icons.access_time; // Pending
    } else if (message.sendingState is MessageSendingStateFailed) {
      return Icons.error_outline; // Failed
    }
    return Icons.done;
  }
}