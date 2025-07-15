import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';
import 'package:repository/repository.dart';
import '../../../app_bloc.dart';

class MeCubit extends Cubit<User?> {
  MeCubit(
      this._getMeUseCase,
      this._downloadFileUseCase,
      this._getFileUseCase,
      ) : super(null) {
    _init();
  }

  final GetMeUseCase _getMeUseCase;
  final DownloadFileUseCase _downloadFileUseCase;
  final GetFileUseCase _getFileUseCase;

  int? _myId;

  Future<void> _init() async {
    final result = await _getMeUseCase.get();

    if (result.isSuccess && result.data != null) {
      final user = result.data;
      _myId = user.id;

      await _downloadProfilePhoto(user);
      emit(user);

      _listenToUserUpdates(); // start listening AFTER getting my id
    }
  }

  Future<void> _downloadProfilePhoto(User user) async {
    final photo = user.profilePhoto;
    if (photo != null) {
      final small = photo.small;
      if (small.local.path.isEmpty || !small.local.isDownloadingCompleted) {
        await _downloadFileUseCase.download(
          fileId: small.id,
          priority: 1,
          offset: 0,
          limit: 0,
          synchronous: true,
        );
      }
    }
  }

  void _listenToUserUpdates() {
    TelegramServiceHelper.getTelegramService()
        .listen<UpdateUser>()
        .listen((event) async {
      final updatedUser = event.user;

      if (updatedUser.id != _myId) return; // 🛑 Ignore other users!

      await _downloadProfilePhoto(updatedUser);

      final current = state;
      final updatedPhotoId = updatedUser.profilePhoto?.small.id;
      final currentPhotoId = current?.profilePhoto?.small.id;

      if (current == null ||
          updatedUser.firstName != current.firstName ||
          updatedPhotoId != currentPhotoId) {
        emit(updatedUser);
      }
    });
  }
}