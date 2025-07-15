import 'package:tdlib/td_api.dart';

class Result<T> {
  final T? _data;
  final String? _error;
  
  Result._(this._data, this._error);
  
  factory Result.success(T data) => Result._(data, null);
  factory Result.failure(String error) => Result._(null, error);
  
  bool get isSuccess => _error == null;
  bool get isFailure => _error != null;
  
  T get data {
    if (_error != null) throw StateError('Result is failure');
    return _data!;
  }
  
  String get error {
    if (_error == null) throw StateError('Result is success');
    return _error!;
  }
}