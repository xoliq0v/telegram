import 'dart:async';

import 'package:core/core.dart' hide ConnectionState;
import 'package:tdlib/td_client.dart';
import 'package:tdlib/td_api.dart';

import '../../telegram_database_lib.dart';

class TdLibListenerService {
  final Client _client;
  final Logger _logger = Logger();

  final _stream = StreamController<TdObject>.broadcast();

  TdLibListenerService(this._client) {
    _startListening();
  }

  void _startListening() {
    _client.updates.listen((event) {
      _stream.add(event);
    });
  }


  Stream<T> listen<T extends TdObject>() {
    return _stream.stream
        .where((event) => event is T)
        .cast<T>();
  }

  Future<T> send<T extends TdObject>(TdFunction function) async {
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

  Stream<TdObject> get stream => _stream.stream;

  Stream<AuthorizationState> get authStream =>
      _stream.stream
          .where((e) => e is UpdateAuthorizationState)
          .map((e) => (e as UpdateAuthorizationState).authorizationState);

  Stream<Message> get newMessageStream =>
      _stream.stream
          .where((e) => e is UpdateNewMessage)
          .map((e) => (e as UpdateNewMessage).message);

  Stream<Chat> get newChatStream =>
      _stream.stream
          .where((e) => e is UpdateNewChat)
          .map((e) => (e as UpdateNewChat).chat);

  Stream<Error> get errorStream =>
      _stream.stream
          .where((e) => e is Error)
          .cast<Error>();

  Stream<ConnectionState> get connectionStream =>
      _stream.stream
          .where((e) => e is UpdateConnectionState)
          .map((e) => (e as UpdateConnectionState).state);


  Stream<File> get updateFilestream =>
      _stream.stream
          .where((e) => e is UpdateFile)
          .map((e) => (e as UpdateFile).file);

  Stream<ChatPosition> get updateChatPosition =>
      _stream.stream
          .where((e) => e is UpdateChatPosition)
          .map((e) => (e as UpdateChatPosition).position);


  Stream<UpdateChatLastMessage> get streamLatestMessage =>
      _stream.stream
          .where((e) => e is UpdateChatLastMessage)
          .map((e) => (e as UpdateChatLastMessage));


  Stream<User> get updateUserStream =>
      _stream.stream
          .where((e) => e is UpdateUser)
          .map((e) => (e as UpdateUser).user);


}