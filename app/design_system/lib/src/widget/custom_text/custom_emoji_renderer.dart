import 'package:flutter/material.dart';
import 'emoji_config.dart';
import 'dart:convert';

class EmojiParser {
  static TextSpan buildTextSpan(String text, {
    TextStyle? style,
    double emojiSize = 24,
  }) {
    final spans = <InlineSpan>[];
    final regex = EmojiConfig.emojiRegex;
    final matches = regex.allMatches(text);

    int last = 0;

    for (final match in matches) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start), style: style));
      }

      final emoji = match.group(0)!;
      final asset = EmojiConfig.getAssetPath(emoji);

      if (asset != null) {
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Image.asset(
            asset,
            width: emojiSize,
            height: emojiSize,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return Text(emoji, style: style?.copyWith(fontSize: emojiSize * 0.8));
            },
          ),
        ));
      } else {
        spans.add(TextSpan(text: emoji, style: style));
      }

      last = match.end;
    }

    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: style));
    }

    return TextSpan(children: spans);
  }
}