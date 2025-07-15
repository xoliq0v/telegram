import 'package:intl/intl.dart';

extension FormatLastMessageDate on int {
  String toLastDate() {
    if (this == 0) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return DateFormat('HH:mm').format(date);
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return DateFormat('EEE').format(date);
    } else if (now.year == date.year) {
      return DateFormat('MMM d').format(date);
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }
}

