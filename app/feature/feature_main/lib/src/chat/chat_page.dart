import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:feature_main/src/chat/widget/chat_app_bar_widget.dart';
import 'package:feature_main/src/chat/widget/chat_input_field_widget.dart';
import 'package:feature_main/src/chat/widget/chat_message_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';

@RoutePage()
class ChatPage extends StatefulWidget implements AutoRouteWrapper{
  final Chat chat;
  const ChatPage({super.key,required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ChatMessageCubit>(
            create: (context) => ChatMessageCubit(),
          ),
          BlocProvider<UserManagerCubit>(
            create: (context) => AppBlocHelper.getUserManagerCubit(),
          ),
        ],
        child: this
    );
  }
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: ChatAppBar(chat: widget.chat,),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ChatMessageList(chatId: widget.chat.id,)),
            const ChatInputField(),
          ],
        ),
      ),
    );
  }
}
