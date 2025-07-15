import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;

class PhotoWidget extends StatefulWidget {
  final Photo photo;
  final double width;
  final double borderRadius;

  const PhotoWidget({
    super.key,
    required this.photo,
    this.width = 220,
    this.borderRadius = 16,
  });

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  late final ValueNotifier<_PhotoState> _photoState;
  late final File _file;
  late final String? _miniThumb;
  StreamSubscription? _fileUpdateSubscription;

  @override
  void initState() {
    super.initState();

    try {
      _file = _getBestFile(widget.photo);
      _miniThumb = widget.photo.minithumbnail?.data;

      final downloaded = _file.local.path.isNotEmpty &&
          io.File(_file.local.path).existsSync();
      _photoState = ValueNotifier<_PhotoState>(
        downloaded ? _PhotoState.downloaded : _PhotoState.initial,
      );

      _listenToFileUpdates();
    } catch (e) {
      _photoState = ValueNotifier<_PhotoState>(_PhotoState.error);
      debugPrint('Error initializing PhotoWidget: $e');
    }
  }

  void _listenToFileUpdates() {
    _fileUpdateSubscription = TdServiceHelper.geTdService()
        .updateFilestream
        .where((update) => update.id == _file.id)
        .listen((update) {
      if (update.local.isDownloadingCompleted &&
          update.local.path.isNotEmpty &&
          io.File(update.local.path).existsSync()) {
        if (mounted) {
          _photoState.value = _PhotoState.downloaded;
        }
      }
    });
  }

  File _getBestFile(Photo photo) {
    if (photo.sizes.isEmpty) {
      throw Exception("Photo has no sizes");
    }

    // Choose medium size for better performance, or largest if medium not available
    final mediumSize = photo.sizes.where((size) =>
    size.type == 'm' || size.type == 'x' || size.type == 'y'
    ).lastOrNull;

    return mediumSize?.photo ?? photo.sizes.last.photo;
  }

  Future<void> _download() async {
    if (_photoState.value == _PhotoState.downloading) return;

    _photoState.value = _PhotoState.downloading;

    try {
      await TdServiceHelper.geTdService().send(DownloadFile(
        fileId: _file.id,
        priority: 1,
        offset: 0,
        limit: 0,
        synchronous: false,
      ));
    } catch (e) {
      debugPrint('Error downloading photo: $e');
      if (mounted) {
        _photoState.value = _PhotoState.initial;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_PhotoState>(
      valueListenable: _photoState,
      builder: (context, state, _) {
        Widget content;

        switch (state) {
          case _PhotoState.downloaded:
            final path = _file.local.path;
            if (path.isNotEmpty && io.File(path).existsSync()) {
              content = Image.file(
                io.File(path),
                fit: BoxFit.cover,
                width: widget.width,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading image: $error');
                  return _buildErrorWidget();
                },
              );
            } else {
              content = _buildErrorWidget();
            }
            break;

          case _PhotoState.downloading:
            content = Stack(
              alignment: Alignment.center,
              children: [
                if (_miniThumb != null) _buildMiniThumb(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            );
            break;

          case _PhotoState.initial:
            content = GestureDetector(
              onTap: _download,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_miniThumb != null)
                    _buildMiniThumb()
                  else
                    Container(
                      width: widget.width,
                      height: widget.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            );
            break;

          case _PhotoState.error:
            content = _buildErrorWidget();
            break;
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: SizedBox(
            width: widget.width,
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: content,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniThumb() {
    try {
      if (_miniThumb == null) return const SizedBox();

      final bytes = base64Decode(_miniThumb!);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: widget.width,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: widget.width,
            height: widget.width * 0.6,
            color: Colors.grey.shade300,
          );
        },
      );
    } catch (e) {
      debugPrint('Error decoding miniThumb: $e');
      return Container(
        width: widget.width,
        height: widget.width * 0.6,
        color: Colors.grey.shade300,
      );
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, color: Colors.grey, size: 48),
          SizedBox(height: 8),
          Text(
            'Failed to load image',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fileUpdateSubscription?.cancel();
    _photoState.dispose();
    super.dispose();
  }
}

enum _PhotoState {
  initial,
  downloading,
  downloaded,
  error,
}