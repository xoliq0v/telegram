import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTimeWidget extends StatelessWidget {
  final int timestamp;

  const MessageTimeWidget({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));

    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        time,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}