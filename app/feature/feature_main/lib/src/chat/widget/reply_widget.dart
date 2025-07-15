import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

class ReplyWidget extends StatefulWidget {
  final MessageReplyTo? replyTo;
  const ReplyWidget({super.key, required this.replyTo});

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  Message? _message;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.replyTo != null) {
      final cubit = context.read<ChatMessageCubit>();
      cubit.getMessage(widget.replyTo!).then((result) {
        if (mounted) {
          setState(() {
            if (result is Message) _message = result;
            _loading = false;
          });
        }
      });
    } else {
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _message == null) return const SizedBox.shrink();

    final sender = _message!.senderId;
    final senderName = sender is MessageSenderUser
        ? sender.userId.toString()
        : sender is MessageSenderChat
        ? "Channel ${sender.chatId}"
        : "Unknown";

    Widget preview = const SizedBox.shrink();
    String subtitle = "Unsupported message";

    final content = _message!.content;

    if (content is MessageText) {
      subtitle = content.text.text;
    } else if (content is MessagePhoto) {
      subtitle = content.caption.text.isNotEmpty ? content.caption.text : "Photo";
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.image, size: 18, color: Colors.grey),
      );
    } else if (content is MessageVideo) {
      subtitle = content.caption.text.isNotEmpty ? content.caption.text : "Video";
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.videocam, size: 18, color: Colors.grey),
      );
    } else if (content is MessageVoiceNote) {
      subtitle = "Voice message";
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.mic, size: 18, color: Colors.grey),
      );
    } else if (content is MessageAudio) {
      subtitle = content.audio.title.isNotEmpty ? content.audio.title : "Audio";
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.audiotrack, size: 18, color: Colors.grey),
      );
    } else if (content is MessageDocument) {
      subtitle = content.document.fileName;
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.description, size: 18, color: Colors.grey),
      );
    } else if (content is MessageAnimation) {
      subtitle = content.caption.text.isNotEmpty ? content.caption.text : "GIF";
      preview = Container(
        padding: const EdgeInsets.only(right: 8),
        child: const Icon(Icons.gif, size: 18, color: Colors.grey),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(
            width: 3,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Row(
        children: [
          if (preview is! SizedBox) preview,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}