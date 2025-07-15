import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

class TextMessageWidget extends StatelessWidget {
  final MessageText message;
  final bool isOutgoing;

  const TextMessageWidget({
    super.key,
    required this.message,
    this.isOutgoing = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // return SelectableText(
    //   (message as MessageText).text.text,
    //   style: TextStyle(
    //     fontSize: 15,
    //     color: isOutgoing
    //         ? (isDark ? Colors.white : Colors.blue[900])
    //         : (isDark ? Colors.white : Colors.black87),
    //     height: 1.3,
    //   ),
    // );

    return CustomTextR(
      text: (message).text.text,
      defaultStyle: TextStyle(
          fontSize: 15,
          color: isOutgoing
              ? (isDark ? Colors.white : Colors.blue[900])
              : (isDark ? Colors.white : Colors.black87),
          height: 1.3,
        ),
    );
  }
}