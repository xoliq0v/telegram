part of 'main_chats_bloc.dart';

class MainChatsState extends Equatable {
  const MainChatsState({
    this.chats = const [],
    this.isInitialLoading = true,
    this.isPaginationLoading = false,
    this.error = '',
    this.errorPagination = '',
    this.loadedAll = false
  });

  final List<Chat> chats;
  final bool isInitialLoading;
  final bool isPaginationLoading;
  final String? error;
  final String? errorPagination;
  final bool loadedAll;

  MainChatsState copyWith({
    List<Chat>? chats,
    bool? isInitialLoading,
    bool? isPaginationLoading,
    String? error,
    String? errorPagination,
    bool? loadedAll
  }){
    return MainChatsState(
        chats: chats ?? this.chats,
        isInitialLoading: isInitialLoading ?? this.isInitialLoading,
        isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
        error: error ?? this.error,
        errorPagination: errorPagination ?? this.errorPagination,
        loadedAll: loadedAll ?? this.loadedAll
    );
  }

  @override
  List<Object?> get props => [
    chats,
    isInitialLoading,
    isPaginationLoading,
    error,
    errorPagination,
    loadedAll
  ];
}