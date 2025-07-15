import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart' hide Animation;
import 'package:tdlib/td_api.dart' hide Text;

/// Thumbnail widget for message previews
class ThumbnailWidget extends StatelessWidget {
  final String? minithumbnail;
  final String? thumbnailPath;
  final bool isRound;
  final double size;
  final IconData? fallbackIcon;

  const ThumbnailWidget({
    super.key,
    this.minithumbnail,
    this.thumbnailPath,
    this.isRound = false,
    this.size = 24.0,
    this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    Widget thumbnail;

    if (minithumbnail != null && minithumbnail!.isNotEmpty) {
      thumbnail = _buildBase64Thumbnail();
    } else if (thumbnailPath != null && thumbnailPath!.isNotEmpty) {
      thumbnail = _buildFileThumbnail();
    } else {
      thumbnail = _buildFallbackThumbnail();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isRound ? size / 2 : 4),
        color: Colors.grey.withOpacity(0.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: thumbnail,
    );
  }

  Widget _buildBase64Thumbnail() {
    try {
      final bytes = base64Decode(minithumbnail!);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _buildFallbackThumbnail(),
      );
    } catch (e) {
      return _buildFallbackThumbnail();
    }
  }

  Widget _buildFileThumbnail() {
    return Image.network(
      thumbnailPath!,
      fit: BoxFit.cover,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) => _buildFallbackThumbnail(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingThumbnail();
      },
    );
  }

  Widget _buildFallbackThumbnail() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.withOpacity(0.3),
      child: Icon(
        fallbackIcon ?? Icons.image,
        size: size * 0.6,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildLoadingThumbnail() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.withOpacity(0.2),
      child: Center(
        child: SizedBox(
          width: size * 0.5,
          height: size * 0.5,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

/// Photo message preview
class PhotoPreview extends StatelessWidget {
  final Photo photo;
  final double size;

  const PhotoPreview({
    super.key,
    required this.photo,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return ThumbnailWidget(
      minithumbnail: photo.minithumbnail?.data,
      size: size,
      fallbackIcon: Icons.photo,
    );
  }
}

/// Video message preview
class VideoPreview extends StatelessWidget {
  final Video video;
  final double size;

  const VideoPreview({
    super.key,
    required this.video,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThumbnailWidget(
          minithumbnail: video.minithumbnail?.data,
          size: size,
          fallbackIcon: Icons.videocam,
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatDuration(video.duration),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Video note (round video) preview
class VideoNotePreview extends StatelessWidget {
  final VideoNote videoNote;
  final double size;

  const VideoNotePreview({
    super.key,
    required this.videoNote,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThumbnailWidget(
          minithumbnail: videoNote.minithumbnail?.data,
          size: size,
          isRound: true,
          fallbackIcon: Icons.videocam,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.white.withOpacity(0.9),
            size: size * 0.6,
          ),
        ),
      ],
    );
  }
}

/// Animation (GIF) preview
class AnimationPreview extends StatelessWidget {
  final Animation animation;
  final double size;

  const AnimationPreview({
    super.key,
    required this.animation,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThumbnailWidget(
          minithumbnail: animation.minithumbnail?.data,
          size: size,
          fallbackIcon: Icons.gif,
        ),
        Positioned(
          top: 2,
          left: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'GIF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Sticker preview
class StickerPreview extends StatelessWidget {
  final Sticker sticker;
  final double size;

  const StickerPreview({
    super.key,
    required this.sticker,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    if (sticker.thumbnail != null) {
      return ThumbnailWidget(
        thumbnailPath: sticker.thumbnail!.file.local.path,
        size: size,
        fallbackIcon: Icons.emoji_emotions,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          sticker.emoji ?? '😊',
          style: TextStyle(fontSize: size * 0.7),
        ),
      ),
    );
  }
}

/// Document preview
class DocumentPreview extends StatelessWidget {
  final Document document;
  final double size;

  const DocumentPreview({
    super.key,
    required this.document,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = document.fileName ?? 'document';
    final extension = fileName.split('.').last.toLowerCase();

    IconData icon;
    Color color;

    switch (extension) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        break;
      case 'doc':
      case 'docx':
        icon = Icons.description;
        color = Colors.blue;
        break;
      case 'xls':
      case 'xlsx':
        icon = Icons.table_chart;
        color = Colors.green;
        break;
      case 'ppt':
      case 'pptx':
        icon = Icons.slideshow;
        color = Colors.orange;
        break;
      case 'zip':
      case 'rar':
      case '7z':
        icon = Icons.archive;
        color = Colors.purple;
        break;
      case 'txt':
        icon = Icons.text_snippet;
        color = Colors.grey;
        break;
      default:
        icon = Icons.insert_drive_file;
        color = Colors.grey;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Icon(
        icon,
        size: size * 0.6,
        color: color,
      ),
    );
  }
}

/// Audio preview
class AudioPreview extends StatelessWidget {
  final Audio audio;
  final double size;

  const AudioPreview({
    super.key,
    required this.audio,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Icon(
        Icons.music_note,
        size: size * 0.6,
        color: Colors.blue,
      ),
    );
  }
}

/// Voice note preview
class VoiceNotePreview extends StatelessWidget {
  final VoiceNote voiceNote;
  final double size;

  const VoiceNotePreview({
    super.key,
    required this.voiceNote,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Icon(
        Icons.mic,
        size: size * 0.6,
        color: Colors.green,
      ),
    );
  }
}

/// Contact preview
class ContactPreview extends StatelessWidget {
  final Contact contact;
  final double size;

  const ContactPreview({
    super.key,
    required this.contact,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Icon(
        Icons.person,
        size: size * 0.6,
        color: Colors.orange,
      ),
    );
  }
}

/// Location preview
class LocationPreview extends StatelessWidget {
  final Location location;
  final double size;

  const LocationPreview({
    super.key,
    required this.location,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Icon(
        Icons.location_on,
        size: size * 0.6,
        color: Colors.red,
      ),
    );
  }
}

/// Helper function to format duration
String _formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;

  if (minutes > 0) {
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  } else {
    return '0:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}