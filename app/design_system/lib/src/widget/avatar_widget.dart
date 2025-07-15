import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text;
import 'package:app_bloc/app_bloc.dart';

class AvatarWidget extends StatefulWidget {
  final int? userId;
  final int? fileId;
  final String? miniThumb;
  final double radius;
  final String? initial;

  const AvatarWidget({
    super.key,
    this.userId,
    this.fileId,
    this.miniThumb,
    this.radius = 28,
    this.initial
  });

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  User? _user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (widget.userId == null) return;

    setState(() => _isLoading = true);

    final userManager = AppBlocHelper.getUserManagerCubit();

    // Avval cache'dan tekshirish
    _user = userManager.getCachedUser(widget.userId!);
    if (_user != null) {
      setState(() => _isLoading = false);
      return;
    }

    // Agar cache'da yo'q bo'lsa, API'dan olish
    _user = await userManager.getUser(widget.userId!);
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarCubit = AppBlocHelper.getAvatarCubit();

    // User ma'lumotlarini olish
    final effectiveFileId = widget.fileId ?? _user?.profilePhoto?.small?.id;
    final effectiveMiniThumb = widget.miniThumb ?? _user?.profilePhoto?.minithumbnail?.data;

    if (effectiveFileId == null) {
      return TelegramStyleAvatar(
        initials: _getInitials(),
        radius: widget.radius,
        backgroundColor: _getAvatarColor(),
      );
    }

    if (!avatarCubit.hasFile(effectiveFileId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        avatarCubit.download(effectiveFileId);
      });
    }

    return StreamBuilder<String?>(
      stream: avatarCubit.fileStream(effectiveFileId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildFallbackAvatar();
        }

        final path = snapshot.data;

        if (path != null && io.File(path).existsSync()) {
          return CircleAvatar(
            radius: widget.radius,
            backgroundImage: FileImage(io.File(path)),
            onBackgroundImageError: (_, __) {
              debugPrint('Failed to load avatar image from path: $path');
            },
          );
        }

        if (effectiveMiniThumb != null) {
          try {
            final bytes = base64Decode(effectiveMiniThumb);
            return CircleAvatar(
              radius: widget.radius,
              backgroundImage: MemoryImage(bytes),
              onBackgroundImageError: (_, __) {
                debugPrint('Failed to load miniThumb image');
              },
            );
          } catch (e) {
            debugPrint('Failed to decode miniThumb: $e');
          }
        }

        return _buildFallbackAvatar();
      },
    );
  }

  Widget _buildFallbackAvatar() {
    return TelegramStyleAvatar(
      initials: _getInitials(),
      radius: widget.radius,
      backgroundColor: _getAvatarColor(),
    );
  }

  String _getInitials() {
    if (widget.initial != null && widget.initial!.isNotEmpty) {
      return widget.initial!;
    }

    if (_user != null) {
      final firstName = _user!.firstName;
      final lastName = _user!.lastName;

      if (firstName.isNotEmpty && lastName.isNotEmpty) {
        return '${firstName[0]}${lastName[0]}';
      } else if (firstName.isNotEmpty) {
        return firstName.substring(0, firstName.length >= 2 ? 2 : 1);
      } else if (lastName.isNotEmpty) {
        return lastName.substring(0, lastName.length >= 2 ? 2 : 1);
      }
    }

    if (widget.userId != null) {
      return _getInitialsFromUserId(widget.userId!);
    }

    return '--';
  }

  Color _getAvatarColor() {
    int? id = widget.userId ?? _user?.id;

    if (id == null) {
      return Colors.grey; // Fallback color if ID is unknown
    }

    final colors = [
      Colors.red.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
      Colors.teal.shade400,
      Colors.pink.shade400,
      Colors.indigo.shade400,
    ];

    return colors[id.abs() % colors.length];
  }

  String _getInitialsFromUserId(int userId) {
    final idStr = userId.toString();
    if (idStr.length >= 2) {
      return idStr.substring(idStr.length - 2);
    } else {
      return idStr;
    }
  }
}

class TelegramStyleAvatar extends StatelessWidget {
  final String initials;
  final double radius;
  final Color backgroundColor;

  const TelegramStyleAvatar({
    super.key,
    required this.initials,
    required this.radius,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.white, Color(0xFFE0E0E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.6,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}