part of 'chat_cubit.dart';

class ChatMessageState {
  final List<Message> messages;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int? lastMessageId;
  final String? backgroundImagePath;

  const ChatMessageState({
    required this.messages,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.lastMessageId,
    this.backgroundImagePath,
  });

  ChatMessageState copyWith({
    List<Message>? messages,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? lastMessageId,
    String? backgroundImagePath,
  }) {
    return ChatMessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
    );
  }

  @override
  String toString() {
    return 'ChatMessageState(messages: ${messages.length}, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, lastMessageId: $lastMessageId)';
  }
}