import 'dart:async';
import 'dart:io' as io;

import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart';
import 'package:use_case/use_case.dart';

enum AvatarState {
  loading,
  small,
  big,
}


class AvatarCubit extends Cubit<void> {
  AvatarCubit(this._getFileUseCase, this._downloadFileUseCase) : super(null) {
    _listenToFileUpdates();
  }

  final GetFileUseCase _getFileUseCase;
  final DownloadFileUseCase _downloadFileUseCase;

  final Map<int, BehaviorSubject<String?>> _fileStreams = {};

  Future<void> download(int fileId) async {
    if (_fileStreams[fileId]?.hasValue == true) return;

    final result = await _getFileUseCase.get(fileId: fileId);

    // Check if result is successful before accessing data
    if (result.isSuccess) {
      final localPath = result.data.local.path;

      if (localPath.isNotEmpty && io.File(localPath).existsSync()) {
        _fileStreams
            .putIfAbsent(fileId, () => BehaviorSubject<String?>())
            .add(localPath);
        return; // File already exists, no need to download
      }
    }

    // If file doesn't exist or result failed, attempt to download
    try {
      await _downloadFileUseCase.download(
        fileId: fileId,
        priority: 1,
        offset: 0,
        limit: 0,
        synchronous: false,
      );
    } catch (e) {
      // Handle download error gracefully
      if (kDebugMode) {
        print('Failed to download file $fileId: $e');
      }
      // Optionally, you can add a placeholder or error state to the stream
      _fileStreams
          .putIfAbsent(fileId, () => BehaviorSubject<String?>())
          .add(null);
    }
  }

  Stream<String?> fileStream(int fileId) {
    return _fileStreams
        .putIfAbsent(fileId, () => BehaviorSubject<String?>())
        .stream;
  }

  bool hasFile(int fileId) => _fileStreams.containsKey(fileId);

  void _listenToFileUpdates() {
    TdServiceHelper.geTdService().updateFilestream.listen((update) {
      if (update.local.isDownloadingCompleted &&
          update.local.path.isNotEmpty &&
          io.File(update.local.path).existsSync()) {
        final subject = _fileStreams[update.id];
        if (subject != null && !subject.isClosed) {
          subject.add(update.local.path);
        }
      }
    });
  }

  // Future<void> download(int fileId) async {
  //   if (_fileStreams[fileId]?.hasValue == true) return;
  //
  //   final result = await _getFileUseCase.get(fileId: fileId);
  //   final localPath = result.data.local.path;
  //
  //   if (result.isSuccess && localPath.isNotEmpty && io.File(localPath).existsSync()) {
  //     _fileStreams
  //         .putIfAbsent(fileId, () => BehaviorSubject<String?>())
  //         .add(localPath);
  //   } else {
  //     await _downloadFileUseCase.download(
  //       fileId: fileId,
  //       priority: 1,
  //       offset: 0,
  //       limit: 0,
  //       synchronous: false,
  //     );
  //   }
  // }

  @override
  Future<void> close() async {
    for (var stream in _fileStreams.values) {
      await stream.close();
    }
    return super.close();
  }
}