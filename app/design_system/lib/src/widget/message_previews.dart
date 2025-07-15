import 'dart:convert';
import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:tdlib/td_api.dart' hide Text, RichText, ConnectionState;
import 'package:core/core.dart';
import 'package:design_system/src/app_theme.dart';
import 'custom_text/custom_text.dart';
import 'message_entities_widgets.dart';
import 'message_previews.dart';

class LastMessageWidget extends StatelessWidget {
  final Message? message;
  final bool isGroup;
  final String? senderName;

  const LastMessageWidget({
    super.key,
    required this.message,
    this.isGroup = false,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    final msg = message?.content;
    if (msg == null) return const SizedBox.shrink();

    final style = context.chatSubtitle;

    Widget contentWidget = _buildMessageContent(msg, context, style);

    if (isGroup && senderName != null) {
      return Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: style,
                children: [
                  TextSpan(
                    text: "$senderName: ",
                    style: style.copyWith(fontWeight: FontWeight.w600),
                  ),
                  WidgetSpan(child: contentWidget),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return contentWidget;
  }

  Widget _buildMessageContent(MessageContent msg, BuildContext context, TextStyle? style) {
    switch (msg.runtimeType) {
      case MessageText:
        return _buildTextMessage(msg as MessageText, context);

      case MessagePhoto:
        return _buildPhotoMessage(msg as MessagePhoto, context, style);

      case MessageVideo:
        return _buildVideoMessage(msg as MessageVideo, context, style);

      case MessageVideoNote:
        return _buildVideoNoteMessage(msg as MessageVideoNote, context, style);

      case MessageVoiceNote:
        return _buildVoiceNoteMessage(msg as MessageVoiceNote, context, style);

      case MessageAudio:
        return _buildAudioMessage(msg as MessageAudio, context, style);

      case MessageDocument:
        return _buildDocumentMessage(msg as MessageDocument, context, style);

      case MessageSticker:
        return _buildStickerMessage(msg as MessageSticker, context, style);

      case MessageAnimation:
        return _buildAnimationMessage(msg as MessageAnimation, context, style);

      case MessageLocation:
        return _buildLocationMessage(context, style);

      case MessageContact:
        return _buildContactMessage(msg as MessageContact, context, style);

      case MessagePoll:
        return _buildPollMessage(msg as MessagePoll, context, style);

      case MessageChatAddMembers:
        return _buildChatAddMembersMessage(msg as MessageChatAddMembers, context, style);

      case MessageChatJoinByLink:
        return _buildSimpleMessage("Joined via invite link", context, style);

      case MessageChatJoinByRequest:
        return _buildSimpleMessage("Joined by request", context, style);

      case MessageChatDeleteMember:
        return _buildChatDeleteMemberMessage(msg as MessageChatDeleteMember, context, style);

      case MessageChatChangeTitle:
        return _buildChatChangeTitleMessage(msg as MessageChatChangeTitle, context, style);

      case MessageChatChangePhoto:
        return _buildSimpleMessage("Changed group photo", context, style);

      case MessageChatDeletePhoto:
        return _buildSimpleMessage("Deleted group photo", context, style);

      case MessagePinMessage:
        return _buildSimpleMessage("Pinned a message", context, style);

      case MessageScreenshotTaken:
        return _buildSimpleMessage("Screenshot taken", context, style);

      // case MessageChatSetTtl:
      //   return _buildChatSetTtlMessage(msg as MessageChatSetTtl, context, style);

      case MessageCall:
        return _buildCallMessage(msg as MessageCall, context, style);

      case MessageVideoChatStarted:
        return _buildSimpleMessage("Video chat started", context, style);

      case MessageVideoChatEnded:
        return _buildSimpleMessage("Video chat ended", context, style);

      case MessageInviteVideoChatParticipants:
        return _buildSimpleMessage("Invited to video chat", context, style);

      case MessageBasicGroupChatCreate:
        return _buildSimpleMessage("Group created", context, style);

      case MessageSupergroupChatCreate:
        return _buildSimpleMessage("Group created", context, style);

      case MessageChatUpgradeTo:
        return _buildSimpleMessage("Group upgraded", context, style);

      case MessageChatUpgradeFrom:
        return _buildSimpleMessage("Group upgraded", context, style);

      // case MessageWebsiteConnected:
      //   return _buildWebsiteConnectedMessage(msg as MessageWebsiteConnected, context, style);

      case MessagePassportDataSent:
        return _buildSimpleMessage("Passport data sent", context, style);

      case MessagePassportDataReceived:
        return _buildSimpleMessage("Passport data received", context, style);

      case MessageProximityAlertTriggered:
        return _buildSimpleMessage("Proximity alert", context, style);

      case MessageUnsupported:
        return _buildSimpleMessage("Unsupported message", context, style);

      default:
        return _buildSimpleMessage("Unsupported message", context, style);
    }
  }

  Widget _buildTextMessage(MessageText msg, BuildContext context) {
    return _buildFormattedText(msg.text, context, maxLines: 1);
  }

  Widget _buildPhotoMessage(MessagePhoto msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        _buildThumbnail(msg.photo.minithumbnail?.data, isRound: false),
        const SizedBox(width: 8),
        Expanded(
          child: _buildFormattedText(
            msg.caption,
            context,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fallbackText: "Photo",
          ),
        ),
      ],
    );
  }

  Widget _buildVideoMessage(MessageVideo msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        _buildThumbnail(msg.video.minithumbnail?.data, isRound: false),
        const SizedBox(width: 8),
        Expanded(
          child: _buildFormattedText(
            msg.caption,
            context,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fallbackText: "Video",
          ),
        ),
      ],
    );
  }

  Widget _buildVideoNoteMessage(MessageVideoNote msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        _buildThumbnail(msg.videoNote.minithumbnail?.data, isRound: true),
        const SizedBox(width: 8),
        Text("Video message", style: style),
      ],
    );
  }

  Widget _buildVoiceNoteMessage(MessageVoiceNote msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        const Icon(CupertinoIcons.mic, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text("Voice message (${msg.voiceNote.duration}s)", style: style),
      ],
    );
  }

  Widget _buildAudioMessage(MessageAudio msg, BuildContext context, TextStyle? style) {
    final title = msg.audio.title?.isNotEmpty == true
        ? msg.audio.title!
        : msg.audio.fileName?.isNotEmpty == true
        ? msg.audio.fileName!
        : "Audio";

    return Row(
      children: [
        const Icon(CupertinoIcons.music_note, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: style, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildDocumentMessage(MessageDocument msg, BuildContext context, TextStyle? style) {
    final fileName = msg.document.fileName?.isNotEmpty == true
        ? msg.document.fileName!
        : "Document";

    return Row(
      children: [
        const Icon(CupertinoIcons.doc, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(child: Text(fileName, style: style, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildStickerMessage(MessageSticker msg, BuildContext context, TextStyle? style) {
    final emoji = msg.sticker.emoji?.isNotEmpty == true ? "${msg.sticker.emoji} " : "";
    return Row(
      children: [
        if (msg.sticker.thumbnail != null)
          _buildThumbnail(msg.sticker.thumbnail!.file.local.path, isRound: false),
        if (msg.sticker.thumbnail != null) const SizedBox(width: 8),
        Text("${emoji}Sticker", style: style),
      ],
    );
  }

  Widget _buildAnimationMessage(MessageAnimation msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        _buildThumbnail(msg.animation.minithumbnail?.data, isRound: false),
        const SizedBox(width: 8),
        Expanded(
          child: _buildFormattedText(
            msg.caption,
            context,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fallbackText: "GIF",
          ),
        ),
      ],
    );
  }

  Widget _buildLocationMessage(BuildContext context, TextStyle? style) {
    return Row(
      children: [
        const Icon(CupertinoIcons.location_solid, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text("Location", style: style),
      ],
    );
  }

  Widget _buildContactMessage(MessageContact msg, BuildContext context, TextStyle? style) {
    final name = "${msg.contact.firstName} ${msg.contact.lastName}".trim();
    return Row(
      children: [
        const Icon(CupertinoIcons.person_crop_circle, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(child: Text(name.isNotEmpty ? name : "Contact", style: style, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildPollMessage(MessagePoll msg, BuildContext context, TextStyle? style) {
    return Row(
      children: [
        Icon(msg.poll.type is PollTypeQuiz ? CupertinoIcons.question_circle : CupertinoIcons.chart_bar, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(child: Text(msg.poll.question.text, style: style, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildChatAddMembersMessage(MessageChatAddMembers msg, BuildContext context, TextStyle? style) {
    final memberCount = msg.memberUserIds.length;
    final text = memberCount == 1 ? "Added 1 member" : "Added $memberCount members";
    return Text(text, style: style);
  }

  Widget _buildChatDeleteMemberMessage(MessageChatDeleteMember msg, BuildContext context, TextStyle? style) {
    return Text("Removed from chat", style: style);
  }

  Widget _buildChatChangeTitleMessage(MessageChatChangeTitle msg, BuildContext context, TextStyle? style) {
    return Text("Changed group title to \"${msg.title}\"", style: style);
  }

  // Widget _buildChatSetTtlMessage(MessageChatSetTtl msg, BuildContext context, TextStyle? style) {
  //   final ttl = msg.ttl;
  //   String text;
  //   if (ttl == 0) {
  //     text = "Disabled auto-delete";
  //   } else if (ttl < 60) {
  //     text = "Set auto-delete to ${ttl}s";
  //   } else if (ttl < 3600) {
  //     text = "Set auto-delete to ${ttl ~/ 60}m";
  //   } else if (ttl < 86400) {
  //     text = "Set auto-delete to ${ttl ~/ 3600}h";
  //   } else {
  //     text = "Set auto-delete to ${ttl ~/ 86400}d";
  //   }
  //   return Text(text, style: style);
  // }

  Widget _buildCallMessage(MessageCall msg, BuildContext context, TextStyle? style) {
    String text;
    switch (msg.discardReason?.runtimeType) {
      case CallDiscardReasonMissed:
        text = "Missed call";
        break;
      case CallDiscardReasonDeclined:
        text = "Declined call";
        break;
      case CallDiscardReasonHungUp:
        text = "Call ended";
        break;
      default:
        text = msg.isVideo ? "Video call" : "Voice call";
    }

    return Row(
      children: [
        Icon(msg.isVideo ? Icons.video_call : Icons.phone, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: style),
      ],
    );
  }

  // Widget _buildWebsiteConnectedMessage(MessageWebsiteConnected msg, BuildContext context, TextStyle? style) {
  //   return Text("Connected to ${msg.domainName}", style: style);
  // }

  Widget _buildSimpleMessage(String text, BuildContext context, TextStyle? style) {
    return Text(text, style: style);
  }

  Widget _buildThumbnail(String? thumbnailData, {required bool isRound}) {
    if (thumbnailData == null || thumbnailData.isEmpty) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(isRound ? 12 : 4),
        ),
        child: const Icon(
          CupertinoIcons.photo,
          size: 16,
          color: Colors.grey,
        ),
      );
    }

    try {
      final bytes = base64Decode(thumbnailData);
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isRound ? 12 : 4),
          image: DecorationImage(
            image: MemoryImage(bytes),
            fit: BoxFit.cover,
          ),
        ),
      );
    } catch (e) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(isRound ? 12 : 4),
        ),
        child: const Icon(
          CupertinoIcons.exclamationmark_bubble,
          size: 16,
          color: Colors.grey,
        ),
      );
    }
  }

  Widget _buildFormattedText(
      FormattedText formattedText,
      BuildContext context, {
        int? maxLines,
        TextOverflow? overflow,
        String? fallbackText,
      }) {
    final style = Theme.of(context).brightness == Brightness.dark
        ? AppTextStyles.darkChatSubtitle
        : AppTextStyles.lightChatSubtitle;

    if (formattedText.text.isEmpty && fallbackText != null) {
      return Text(fallbackText, style: style);
    }

    if (formattedText.entities.isEmpty) {
      return Text(
        formattedText.text,
        style: style,
        maxLines: maxLines,
      );
    }

    return RichText(
      text: buildFormattedTextSpan(formattedText, context),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}