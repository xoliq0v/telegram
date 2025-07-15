class TelegramException implements Exception {
  final String message;
  final int? code;
  
  TelegramException(this.message, [this.code]);
  
  @override
  String toString() => 'TelegramException: $message${code != null ? ' (Code: $code)' : ''}';
}
