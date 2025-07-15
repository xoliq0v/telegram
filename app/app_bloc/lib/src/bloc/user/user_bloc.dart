import 'dart:async';
import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

class UserManagerCubit extends Cubit<Map<int, User>> {
  UserManagerCubit(this._getUserUseCase) : super({}) {
    _listenToUserUpdates();
  }

  final GetUserUseCase _getUserUseCase;
  StreamSubscription? _userUpdateSubscription;

  void _listenToUserUpdates() {
    _userUpdateSubscription = TdServiceHelper.geTdService()
        .updateUserStream
        .listen((user) {
      final currentState = Map<int, User>.from(state);
      currentState[user.id] = user;
      emit(currentState);
    });
  }

  Future<User?> getUser(int userId) async {
    // Agar cache'da bor bo'lsa, uni qaytarish
    if (state.containsKey(userId)) {
      return state[userId];
    }

    try {
      final result = await _getUserUseCase.get(userId);
      if (result.isSuccess) {
        final user = result.data;
        final currentState = Map<int, User>.from(state);
        currentState[userId] = user;
        emit(currentState);
        return user;
      }
    } catch (e) {
      debugPrint('Error getting user $userId: $e');
    }
    return null;
  }

  User? getCachedUser(int userId) {
    return state[userId];
  }

  @override
  Future<void> close() {
    _userUpdateSubscription?.cancel();
    return super.close();
  }
}