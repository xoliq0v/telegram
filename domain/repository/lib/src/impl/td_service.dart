import 'package:tdlib/td_api.dart';
import 'package:tdlib/td_client.dart';
import 'package:logger/logger.dart';
import 'package:repository/repository.dart';
import 'dart:async';

class TdLibService implements TelegramService {
  final Client _client;
  final Logger _logger = Logger();
  
  StreamSubscription<TdObject>? _subscription;
  final _updateController = StreamController<TdObject>.broadcast();
  
  bool _isConnected = false;
  bool _isDisposed = false;
  
  TdLibService(this._client){
    connect();
  }
  
  @override
  Future<void> connect() async {
    if (_isDisposed) throw StateError('Service has been disposed');
    if (_isConnected) return;
    
    try {
      // await _client.initialize();
      _startListening();
      _isConnected = true;
      _logger.i('TdLib connected successfully');
    } catch (e) {
      _logger.e('Failed to connect to TdLib: $e');
      rethrow;
    }
  }
  
  @override
  Future<void> disconnect() async {
    if (!_isConnected) return;
    
    try {
      await _subscription?.cancel();
      await _updateController.close();
      _client.destroy();
      _isConnected = false;
      _logger.i('TdLib disconnected successfully');
    } catch (e) {
      _logger.e('Error during disconnect: $e');
    }
  }
  
  void _startListening() {
    _subscription = _client.updates.listen(
      (update) {
        if (!_updateController.isClosed) {
          _updateController.add(update);
        }
      },
      onError: (error) {
        _logger.e('TdLib update error: $error');
        if (!_updateController.isClosed) {
          _updateController.addError(error);
        }
      },
    );
  }
  
  @override
  Stream<T> listen<T extends TdObject>() {
    return _updateController.stream
        .where((event) => event is T)
        .cast<T>();
  }
  
  @override
  Future<T> send<T extends TdObject>(TdFunction function) async {
    if (!_isConnected) throw StateError('Service not connected');
    
    try {
      final result = await _client.send(function);
      if (result is T) {
        return result;
      }
      throw Exception('Unexpected response type: ${result.runtimeType}');
    } catch (e) {
      _logger.e('Failed to send function ${function.runtimeType}: $e');
      rethrow;
    }
  }
  
  @override
  bool get isConnected => _isConnected;
  
  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;
    await disconnect();
  }
}
