import 'package:flutter/material.dart';

class VoiceMessageWidget extends StatelessWidget {
  final int duration;

  const VoiceMessageWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.mic),
        const SizedBox(width: 8),
        Text('$duration seconds'),
      ],
    );
  }
}