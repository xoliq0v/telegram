import 'package:app_bloc/app_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:repository/repository.dart';

import '../widget/chat_item_real_time_builder_widget.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late final ScrollController _scrollController;
  final Logger _logger = Logger();
  late ChatUpdatesManager chatUpdatesManager;


  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(_onScroll);
    final telegramService = TelegramServiceHelper.getTelegramService();
    chatUpdatesManager = ChatUpdatesManager();
    chatUpdatesManager.initialize(telegramService);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    chatUpdatesManager.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final bloc = context.read<MainChatsBloc>();

    if (_scrollController.position.extentAfter < 100 &&
        !bloc.state.isPaginationLoading &&
        !bloc.state.loadedAll &&
        bloc.state.chats.isNotEmpty) {

      bloc.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainChatsBloc, MainChatsState>(
      builder: (context, state) {
        if (state.isInitialLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.error!.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                ElevatedButton(
                  onPressed: () => context.read<MainChatsBloc>().fetch(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: state.chats.length + (state.isPaginationLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.chats.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final chat = state.chats[index];
            return ChatRealtimeBuilder(
              initialChat: chat,
              key: ValueKey(chat.id),
              builder: (updatedChat) => ChatItemWidget(
                  key: ValueKey(updatedChat.id),
                  chat: updatedChat,
                onTap: (){
                    NavigationUtils.getMainNavigation().navigateChatPage(chat);
                },
              ),
            );
          },
        );
      },
    );
  }
}