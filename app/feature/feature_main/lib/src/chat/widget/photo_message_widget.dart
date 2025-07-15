import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

class PhotoMessageWidget extends StatelessWidget {
  final Photo photo;

  const PhotoMessageWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: PhotoWidget(photo:  photo),
    );
  }
}