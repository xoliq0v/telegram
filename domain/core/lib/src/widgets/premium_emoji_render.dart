import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:lottie/lottie.dart';
import 'package:tdlib/td_api.dart' hide Text;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:repository/repository.dart';

// Emoji data model
class EmojiData {
  final EmojiType type;
  final String filePath;
  final Sticker sticker;

  EmojiData({
    required this.type,
    required this.filePath,
    required this.sticker,
  });
}

enum EmojiType {
  lottie,  // TGS format
  video,   // WebM format
  image,   // WebP format
}

enum ConnectionState {
  none,
  waiting,
  active,
  done,
}

class PremiumEmojiRenderer extends StatefulWidget {
  final int customEmojiId;
  final String fallbackText;
  final double size;

  const PremiumEmojiRenderer({
    super.key,
    required this.customEmojiId,
    required this.fallbackText,
    this.size = 18.0,
  });

  @override
  State<PremiumEmojiRenderer> createState() => _PremiumEmojiRendererState();
}

class _PremiumEmojiRendererState extends State<PremiumEmojiRenderer>
    with SingleTickerProviderStateMixin {

  EmojiData? _emojiData;
  VideoPlayerController? _videoController;
  AnimationController? _animationController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPremiumEmoji();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _animationController?.dispose();

    // Temporary files ni tozalash
    if (_emojiData?.type == EmojiType.lottie && _emojiData?.filePath.endsWith('.json') == true) {
      try {
        final tempFile = io.File(_emojiData!.filePath);
        if (tempFile.existsSync()) {
          tempFile.deleteSync();
        }
      } catch (e) {
        print('Failed to delete temp file: $e');
      }
    }

    super.dispose();
  }

  Future<void> _loadPremiumEmoji() async {
    try {
      final telegram = TelegramServiceHelper.getTelegramService();

      // 1. Oldin emoji ma'lumotlarini olish
      final result = await telegram.send(
        GetCustomEmojiStickers(customEmojiIds: [widget.customEmojiId]),
      );

      if (result is! Stickers || result.stickers.isEmpty) {
        throw Exception('Emoji not found');
      }

      final sticker = result.stickers.first;
      final format = sticker.format;

      print('Emoji format: ${format.runtimeType}');
      print('File ID: ${sticker.sticker.id}');
      print('File path: ${sticker.sticker.local.path}');
      print('Is downloaded: ${sticker.sticker.local.isDownloadingCompleted}');

      // 2. Agar fayl yuklanmagan bo'lsa, yuklab olish
      if (!sticker.sticker.local.isDownloadingCompleted) {
        print('Downloading emoji file...');
        await telegram.send(DownloadFile(
          fileId: sticker.sticker.id,
          priority: 32,
          offset: 0,
          limit: 0,
          synchronous: true,
        ));

        // Yuklab olingandan keyin qayta ma'lumot olish
        await Future.delayed(const Duration(milliseconds: 500));
        final updatedResult = await telegram.send(
          GetCustomEmojiStickers(customEmojiIds: [widget.customEmojiId]),
        );

        if (updatedResult is Stickers && updatedResult.stickers.isNotEmpty) {
          final updatedSticker = updatedResult.stickers.first;
          await _processEmojiFile(updatedSticker);
        }
      } else {
        await _processEmojiFile(sticker);
      }
    } catch (e) {
      print('Premium emoji load error: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<bool> _validateTgsFile(String filePath) async {
    try {
      final file = io.File(filePath);
      final content = await file.readAsString();

      // TGS fayl JSON formatida bo'lishi kerak
      if (!content.trim().startsWith('{')) {
        print('TGS file does not start with JSON: ${content.substring(0, 50)}...');
        return false;
      }

      // JSON parse qilishga harakat qilish
      final jsonData = json.decode(content);
      if (jsonData is! Map) {
        print('TGS file is not a valid JSON object');
        return false;
      }

      // Lottie animation keys ni tekshirish
      if (!jsonData.containsKey('v') || !jsonData.containsKey('fr') || !jsonData.containsKey('layers')) {
        print('TGS file missing required Lottie keys');
        return false;
      }

      return true;
    } catch (e) {
      print('TGS file validation error: $e');
      return false;
    }
  }

  Future<void> _processEmojiFile(Sticker sticker) async {
    final file = sticker.sticker;
    final filePath = file.local.path;

    if (filePath.isEmpty) {
      throw Exception('File path is empty');
    }

    final ioFile = io.File(filePath);
    if (!await ioFile.exists()) {
      throw Exception('File does not exist: $filePath');
    }

    print('Processing emoji file: $filePath');
    print('File size: ${await ioFile.length()} bytes');

    final format = sticker.format;

    if (format is StickerFormatTgs) {
      // TGS - Lottie animation
      print('Loading TGS animation...');

      // Fayl to'g'ri yuklanganini tekshirish
      final fileContent = await ioFile.readAsBytes();
      if (fileContent.isEmpty) {
        throw Exception('TGS file is empty');
      }

      // Gzip compressed bo'lishi mumkin - decompress qilish
      Uint8List finalContent = fileContent;
      try {
        if (fileContent.length > 2 && fileContent[0] == 0x1f && fileContent[1] == 0x8b) {
          // Gzip header detected
          print('Decompressing gzipped TGS file...');
          final decompressed = io.gzip.decode(fileContent);
          finalContent = Uint8List.fromList(decompressed);
        }
      } catch (e) {
        print('Gzip decompression failed, using raw data: $e');
      }

      // Decompressed faylni yozish
      final tempFile = io.File('${filePath}.json');
      await tempFile.writeAsBytes(finalContent);

      final emojiData = EmojiData(
        type: EmojiType.lottie,
        filePath: tempFile.path,
        sticker: sticker,
      );

      if (mounted) {
        setState(() {
          _emojiData = emojiData;
          _isLoading = false;
        });
      }
    } else if (format is StickerFormatWebm) {
      // WebM - Video animation
      print('Loading WebM video...');
      await _initializeVideoPlayer(filePath, sticker);
    } else if (format is StickerFormatWebp) {
      // WebP - Static image
      print('Loading WebP image...');
      final emojiData = EmojiData(
        type: EmojiType.image,
        filePath: filePath,
        sticker: sticker,
      );

      if (mounted) {
        setState(() {
          _emojiData = emojiData;
          _isLoading = false;
        });
      }
    } else {
      throw Exception('Unsupported emoji format: ${format.runtimeType}');
    }
  }

  Future<void> _initializeVideoPlayer(String filePath, Sticker sticker) async {
    try {
      final controller = VideoPlayerController.file(io.File(filePath));
      await controller.initialize();

      controller.setLooping(true);
      controller.setVolume(0.0);

      final emojiData = EmojiData(
        type: EmojiType.video,
        filePath: filePath,
        sticker: sticker,
      );

      if (mounted) {
        setState(() {
          _videoController = controller;
          _emojiData = emojiData;
          _isLoading = false;
        });

        // Video ni boshlash
        await controller.play();
      }
    } catch (e) {
      print('Video player initialization error: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildShimmer();
    }

    if (_hasError || _emojiData == null) {
      return _buildFallback();
    }

    return _buildEmojiWidget();
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: Text(
          widget.fallbackText,
          style: TextStyle(fontSize: widget.size * 0.8),
        ),
      ),
    );
  }

  Widget _buildEmojiWidget() {
    final data = _emojiData!;

    switch (data.type) {
      case EmojiType.lottie:
        return _buildLottieEmoji(data);
      case EmojiType.video:
        return _buildVideoEmoji(data);
      case EmojiType.image:
        return _buildImageEmoji(data);
    }
  }

  Widget _buildLottieEmoji(EmojiData data) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FutureBuilder<bool>(
        future: _validateTgsFile(data.filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmer();
          }

          if (snapshot.hasError || snapshot.data != true) {
            print('TGS file validation failed: ${snapshot.error}');
            return _buildFallback();
          }

          return Lottie.file(
            io.File(data.filePath),
            width: widget.size,
            height: widget.size,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
            options: LottieOptions(
              enableMergePaths: false,
            ),
            errorBuilder: (context, error, stackTrace) {
              print('Lottie error: $error');
              return _buildFallback();
            },
          );
        },
      ),
    );
  }

  Widget _buildVideoEmoji(EmojiData data) {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return _buildFallback();
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      ),
    );
  }

  Widget _buildImageEmoji(EmojiData data) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Image.file(
        io.File(data.filePath),
        width: widget.size,
        height: widget.size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Image error: $error');
          return _buildFallback();
        },
      ),
    );
  }
}

