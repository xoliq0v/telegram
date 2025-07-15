import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:repository/repository.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  final TelegramRepository _repository;
  StreamSubscription<ConnectionState>? _connectionSubscription;

  ConnectionCubit(this._repository) : super(const ConnectionStateConnectingToProxy());

  Future<void> initialize() async {
    try {
      await _repository.initialize();
      _listenToConnectionChanges();
    } catch (e) {
      emit(const ConnectionStateConnectingToProxy());
    }
  }

  void _listenToConnectionChanges() {
    _connectionSubscription = _repository.connectionStream.listen(
          (state) => emit(state),
      onError: (error) => emit(const ConnectionStateConnectingToProxy()),
    );
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}