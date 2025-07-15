import 'package:app_bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' as io;

import 'chat_bubble.dart';

class ChatMessageList extends StatefulWidget {
  final int chatId;

  const ChatMessageList({super.key, required this.chatId});

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<ChatMessageCubit>();
      cubit.initialize(chatId: widget.chatId);
      _scrollController.addListener(() => _onScroll(cubit));
    });
  }

  void _onScroll(ChatMessageCubit cubit) {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessageCubit, ChatMessageState>(
      builder: (context, state) {
        if (state.isLoading && state.messages.isEmpty) {
          return const Center(child: CupertinoActivityIndicator());
        }

        return Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.messages.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CupertinoActivityIndicator(),
                  );
                }

                final msg = state.messages[index];
                return MessageBubble(
                  message: msg,
                  isMine: msg.isOutgoing,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}