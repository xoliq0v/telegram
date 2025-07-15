import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdlib/td_api.dart';
import 'package:repository/repository.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final Chat chat;
  StreamSubscription? _userSub;
  StreamSubscription? _connectionSub;

  StatusCubit(this.chat)
      : super(StatusState(statusText: "Loading...", isOnline: false)) {
    _init();
  }

  void _init() async {
    // 1. Connection status listener
    _connectionSub = TelegramServiceHelper.getTelegramService()
        .listen<UpdateConnectionState>()
        .listen((update) {
      final isConnected = update.state is ConnectionStateReady;
      if (!isConnected) {
        emit(StatusState(statusText: "Connecting...", isOnline: false));
      }
    });

    // 2. Chat type check
    if (chat.type is ChatTypePrivate) {
      final userId = (chat.type as ChatTypePrivate).userId;

      _userSub = TelegramServiceHelper.getTelegramService()
          .listen<UpdateUserStatus>()
          .where((event) => event.userId == userId)
          .listen((event) {
        final status = event.status;
        final text = _getUserStatusText(status);
        final isOnline = status is UserStatusOnline;

        emit(StatusState(statusText: text, isOnline: isOnline));
      });
    } else if (chat.type is ChatTypeSupergroup) {
      final supergroupId = (chat.type as ChatTypeSupergroup).supergroupId;
      final telegram = TelegramServiceHelper.getTelegramService();

      try {
        final supergroup = await telegram.send(GetSupergroup(supergroupId: supergroupId));
        final fullInfo = await telegram.send(GetSupergroupFullInfo(supergroupId: supergroupId));

        if(supergroup is Supergroup) {
          if(fullInfo is SupergroupFullInfo){
            final title = supergroup.isChannel ? "subscribers" : "members";
            final count = fullInfo.memberCount;
            emit(StatusState(
              statusText: "$count $title",
              isOnline: true,
            ));
          }else {
            return;
          }
        }else {return;}
      } catch (e) {
        emit(StatusState(statusText: "Group", isOnline: true));
      }
    } else if (chat.type is ChatTypeBasicGroup) {
      final basicGroupId = (chat.type as ChatTypeBasicGroup).basicGroupId;
      final telegram = TelegramServiceHelper.getTelegramService();

      try {
        final fullInfo = await telegram.send(GetBasicGroupFullInfo(basicGroupId: basicGroupId));
        if(fullInfo is BasicGroupFullInfo){}else {return;}
        final count = fullInfo.members.length;

        emit(StatusState(
          statusText: "$count members",
          isOnline: true,
        ));
      } catch (e) {
        emit(StatusState(statusText: "Group", isOnline: true));
      }
    } else if (chat.type is ChatTypeSecret) {
      emit(StatusState(statusText: "Secret chat", isOnline: true));
    }
  }

  String _getUserStatusText(UserStatus status) {
    if (status is UserStatusOnline) return "online";
    if (status is UserStatusOffline) return "last seen recently";
    if (status is UserStatusEmpty) return "offline";
    if (status is UserStatusRecently) return "last seen recently";
    if (status is UserStatusLastWeek) return "last seen last week";
    if (status is UserStatusLastMonth) return "last seen last month";
    return "unknown";
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _connectionSub?.cancel();
    return super.close();
  }
}