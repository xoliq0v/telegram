import 'package:design_system/design_system.dart';
import 'package:design_system/src/extensions/app_text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:tdlib/td_api.dart' hide RichText,Text;

import 'custom_text/formated_text_utils.dart';
// import 'package:url_launcher/url_launcher.dart';

TextSpan buildFormattedTextSpan(FormattedText formattedText, BuildContext context) {
  if (formattedText.entities.isEmpty) {
    return TextSpan(text: formattedText.text);
  }

  final spans = <TextSpan>[];
  final text = formattedText.text;
  final entities = formattedText.entities;

  entities.sort((a, b) => a.offset.compareTo(b.offset));

  int currentOffset = 0;

  for (final entity in entities) {
    // Add text before entity
    if (entity.offset > currentOffset) {
      spans.add(TextSpan(
        text: text.substring(currentOffset, entity.offset),
      ));
    }

    // Add entity text with formatting
    final entityText = text.substring(
      entity.offset,
      entity.offset + entity.length,
    );

    spans.add(_buildEntitySpan(entity, entityText, context));

    currentOffset = entity.offset + entity.length;
  }

  // Add remaining text
  if (currentOffset < text.length) {
    spans.add(TextSpan(
      text: text.substring(currentOffset),
    ));
  }

  return TextSpan(children: spans);
}

/// Builds a TextSpan for a specific entity
TextSpan _buildEntitySpan(TextEntity entity, String text, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final baseStyle = context.chatSubtitle;

  switch (entity.type.runtimeType) {
    case TextEntityTypeBold:
      return TextSpan(
        text: text,
      );

    case TextEntityTypeItalic:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(fontStyle: FontStyle.italic),
      );

    case TextEntityTypeUnderline:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(decoration: TextDecoration.underline),
      );

    case TextEntityTypeStrikethrough:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(decoration: TextDecoration.lineThrough),
      );

    case TextEntityTypeCode:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontFamily: 'monospace',
        ),
      );

    case TextEntityTypePre:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontFamily: 'monospace',
        ),
      );

    case TextEntityTypePreCode:
      final preCode = entity.type as TextEntityTypePreCode;
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontFamily: 'monospace',
          backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
        ),
      );

    case TextEntityTypeUrl:
      return TextSpan(
        text: text,
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl(text),
      );

    case TextEntityTypeTextUrl:
      final textUrl = entity.type as TextEntityTypeTextUrl;
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl(textUrl.url),
      );

    case TextEntityTypeEmailAddress:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl('mailto:$text'),
      );

    case TextEntityTypePhoneNumber:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _launchUrl('tel:$text'),
      );

    case TextEntityTypeMention:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleMention(text),
      );

    case TextEntityTypeMentionName:
      final mentionName = entity.type as TextEntityTypeMentionName;
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleMentionName(mentionName.userId),
      );

    case TextEntityTypeHashtag:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleHashtag(text),
      );

    case TextEntityTypeCashtag:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleCashtag(text),
      );

    case TextEntityTypeBotCommand:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleBotCommand(text),
      );

    case TextEntityTypeSpoiler:
      return TextSpan(
        text: text,
        style: baseStyle.copyWith(
          backgroundColor: isDark ? Colors.grey[700] : Colors.grey[400],
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => _handleSpoiler(text),
      );

    case TextEntityTypeCustomEmoji:
      final customEmoji = entity.type as TextEntityTypeCustomEmoji;
      return TextSpan(
        text: text,
      );

    default:
      return TextSpan(text: text);
  }
}

/// Launch URL helper
void _launchUrl(String url) async {
  // try {
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   }
  // } catch (e) {
  //   // Handle error silently
  // }
}

/// Handle mention tap
void _handleMention(String mention) {
  // TODO: Navigate to user profile or chat
  print('Mention tapped: $mention');
}

/// Handle mention name tap
void _handleMentionName(int userId) {
  // TODO: Navigate to user profile
  print('Mention name tapped: $userId');
}

/// Handle hashtag tap
void _handleHashtag(String hashtag) {
  // TODO: Search for hashtag
  print('Hashtag tapped: $hashtag');
}

/// Handle cashtag tap
void _handleCashtag(String cashtag) {
  // TODO: Search for cashtag
  print('Cashtag tapped: $cashtag');
}

/// Handle bot command tap
void _handleBotCommand(String command) {
  // TODO: Execute bot command
  print('Bot command tapped: $command');
}

/// Handle spoiler tap
void _handleSpoiler(String text) {
  // TODO: Reveal spoiler content
  print('Spoiler tapped: $text');
}

/// Widget for displaying formatted text with entities
class FormattedTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const FormattedTextWidget({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        );

    return RichText(
      text: TextSpan(
        children: buildEmojiTextSpans(text, effectiveStyle),
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    );
  }
}

/// Simple text widget with entity support
class EntityText extends StatelessWidget {
  final String text;
  final List<TextEntity> entities;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const EntityText({
    super.key,
    required this.text,
    required this.entities,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final formattedText = FormattedText(
      text: text,
      entities: entities,
    );

    return FormattedTextWidget(
      // formattedText: formattedText,
      style: style,
      maxLines: maxLines,
      overflow: overflow, text: text,
    );
  }
}