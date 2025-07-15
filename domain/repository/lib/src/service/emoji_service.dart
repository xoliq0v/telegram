// import 'dart:async';
// import 'dart:io' as io;
// import 'package:core/core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:use_case/use_case.dart';
// import 'package:tdlib/td_api.dart';
//
// import '../../repository.dart';
//
//
// class CustomEmojiController {
//   static final CustomEmojiController _instance = CustomEmojiController._internal();
//   factory CustomEmojiController() => _instance;
//   CustomEmojiController._internal();
//
//   final _cache = <int, ValueNotifier<CustomEmojiState>>{};
//   final _downloadQueue = <int, Completer<void>>{};
//   final _retryCount = <int, int>{};
//
//   // TDLib client reference
//   late TelegramService _client;
//   late TelegramRepository _repo;
//   late StreamSubscription _updateSubscription;
//
//   void initialize(TelegramService client,TelegramRepository repo) {
//     _client = client;
//     _repo = repo;
//     _setupUpdateListener();
//   }
//
//   void _setupUpdateListener() {
//     // TDLib update'larini dinglash
//     _updateSubscription = _repo.updateFile.listen((update) {
//       if (update is UpdateFile) {
//         _handleFileUpdate(update.file);
//       }
//     });
//   }
//
//   void _handleFileUpdate(File file) {
//     final fileId = file.id;
//     if (_cache.containsKey(fileId)) {
//       if (file.local.isDownloadingCompleted && file.local.path.isNotEmpty) {
//         final diskFile = io.File(file.local.path);
//         if (diskFile.existsSync() && diskFile.lengthSync() > 0) {
//           _cache[fileId]?.value = CustomEmojiState.loaded(diskFile);
//           _downloadQueue.remove(fileId)?.complete();
//         }
//       }
//     }
//   }
//
//   ValueNotifier<CustomEmojiState> listen(int fileId) {
//     if (_cache[fileId] == null) {
//       _cache[fileId] = ValueNotifier(CustomEmojiState.loading());
//       _downloadEmoji(fileId);
//     }
//     return _cache[fileId]!;
//   }
//
//   Future<void> _downloadEmoji(int fileId) async {
//     if (_downloadQueue.containsKey(fileId)) {
//       return _downloadQueue[fileId]!.future;
//     }
//
//     final completer = Completer<void>();
//     _downloadQueue[fileId] = completer;
//
//     try {
//       // Retry mechanism
//       final retryCount = _retryCount[fileId] ?? 0;
//       if (retryCount >= 3) {
//         _cache[fileId]?.value = CustomEmojiState.error('Max retries exceeded');
//         completer.complete();
//         return;
//       }
//
//       _retryCount[fileId] = retryCount + 1;
//
//       // 1. Get file info
//       final file = await _client.send(GetFile(fileId: fileId)) as File;
//
//       debugPrint('🎯 Custom emoji $fileId: size=${file.size}, canDownload=${file.local.canBeDownloaded}, isCompleted=${file.local.isDownloadingCompleted}');
//
//       // 2. Check if already downloaded
//       if (file.local.isDownloadingCompleted && file.local.path.isNotEmpty) {
//         final diskFile = io.File(file.local.path);
//         if (diskFile.existsSync() && diskFile.lengthSync() > 0) {
//           _cache[fileId]?.value = CustomEmojiState.loaded(diskFile);
//           completer.complete();
//           return;
//         }
//       }
//
//       // 3. Check if can be downloaded
//       if (!file.local.canBeDownloaded) {
//         // Premium emoji issue - try alternative approach
//         await _tryAlternativeDownload(fileId);
//         completer.complete();
//         return;
//       }
//
//       // 4. Start download with high priority
//       await _client.send(DownloadFile(
//         fileId: fileId,
//         priority: 32,
//         offset: 0,
//         limit: 0,
//         synchronous: false,
//       ));
//
//       // 5. Wait for download with timeout
//       Timer(const Duration(seconds: 15), () {
//         if (!completer.isCompleted) {
//           debugPrint('⏰ Download timeout for emoji $fileId');
//           _cache[fileId]?.value = CustomEmojiState.error('Download timeout');
//           completer.complete();
//         }
//       });
//
//     } catch (e) {
//       debugPrint('💥 Error downloading emoji $fileId: $e');
//
//       // Retry after delay
//       if ((_retryCount[fileId] ?? 0) < 3) {
//         Timer(Duration(seconds: 2), () => _downloadEmoji(fileId));
//       } else {
//         _cache[fileId]?.value = CustomEmojiState.error(e.toString());
//       }
//
//       completer.complete();
//     }
//   }
//
//   Future<void> _tryAlternativeDownload(int fileId) async {
//     try {
//       // Try getting custom emoji stickers
//       final stickers = await _client.send(GetCustomEmojiStickers(
//         customEmojiIds: [fileId],
//       )) as Stickers;
//
//       if (stickers.stickers.isNotEmpty) {
//         final sticker = stickers.stickers.first;
//         final stickerFileId = sticker.sticker.id;
//
//         debugPrint('🎨 Trying to download sticker file $stickerFileId for emoji $fileId');
//
//         // Download sticker file
//         await _client.send(DownloadFile(
//           fileId: stickerFileId,
//           priority: 32,
//           offset: 0,
//           limit: 0,
//           synchronous: false,
//         ));
//
//         // Map sticker file to emoji
//         _cache[fileId] = _cache[stickerFileId] ?? ValueNotifier(CustomEmojiState.loading());
//
//       } else {
//         debugPrint('🚫 No stickers found for emoji $fileId');
//         _cache[fileId]?.value = CustomEmojiState.error('No stickers available');
//       }
//     } catch (e) {
//       debugPrint('🔄 Alternative download failed for $fileId: $e');
//       _cache[fileId]?.value = CustomEmojiState.error('Alternative download failed');
//     }
//   }
//
//   // Force reload specific emoji
//   Future<void> forceReload(int fileId) async {
//     _cache.remove(fileId);
//     _downloadQueue.remove(fileId);
//     _retryCount.remove(fileId);
//
//     // Delete local file if exists
//     try {
//       final file = await _client.send(GetFile(fileId: fileId)) as File;
//       if (file.local.path.isNotEmpty) {
//         final diskFile = io.File(file.local.path);
//         if (diskFile.existsSync()) {
//           await diskFile.delete();
//         }
//       }
//     } catch (e) {
//       debugPrint('Error deleting local file: $e');
//     }
//
//     // Restart download
//     _downloadEmoji(fileId);
//   }
//
//   void preloadEmojis(List<int> emojiIds) {
//     for (final id in emojiIds) {
//       if (!_cache.containsKey(id)) {
//         listen(id);
//       }
//     }
//   }
//
//   void clearCache() {
//     _cache.clear();
//     _downloadQueue.clear();
//     _retryCount.clear();
//   }
//
//   void dispose() {
//     _updateSubscription.cancel();
//     clearCache();
//   }
//
//   // Debug helper
//   Map<String, dynamic> getDebugInfo() {
//     return {
//       'cached_emojis': _cache.length,
//       'downloading': _downloadQueue.length,
//       'retry_counts': _retryCount,
//       'cache_states': _cache.map((k, v) => MapEntry(k, v.value.status.toString())),
//     };
//   }
// }
//
// enum CustomEmojiStatus { loading, loaded, error }
//
// class CustomEmojiState {
//   final CustomEmojiStatus status;
//   final io.File? file;
//   final String? error;
//
//   CustomEmojiState._({
//     required this.status,
//     this.file,
//     this.error,
//   });
//
//   factory CustomEmojiState.loading() => CustomEmojiState._(status: CustomEmojiStatus.loading);
//   factory CustomEmojiState.loaded(io.File file) => CustomEmojiState._(status: CustomEmojiStatus.loaded, file: file);
//   factory CustomEmojiState.error(String error) => CustomEmojiState._(status: CustomEmojiStatus.error, error: error);
// }