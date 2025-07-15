import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_bloc/app_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_database_lib/telegram_database_lib.dart' hide Text, Animation, File;

class IDrawerWidget extends StatefulWidget {
  const IDrawerWidget({super.key});

  @override
  State<IDrawerWidget> createState() => _IDrawerWidgetState();
}

class _IDrawerWidgetState extends State<IDrawerWidget> with SingleTickerProviderStateMixin {
  bool _showAccounts = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleAccounts() {
    setState(() {
      _showAccounts = !_showAccounts;
      if (_showAccounts) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<MeCubit, User?>(
            builder: (context, state) {
              if (state == null) return const SizedBox.shrink();
              final photo = state.profilePhoto;

              return Material(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1D2B3A)
                    : const Color(0xFF548FCB),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 15, 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AvatarWidget(
                          fileId: photo?.small.id,
                          miniThumb: photo?.minithumbnail?.data,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.firstName, style: Theme.of(context).textTheme.titleMedium),
                                  Text('+${state.phoneNumber}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _showAccounts ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              onPressed: _toggleAccounts,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          /// Expanded Accounts Section
          BlocBuilder<MeCubit, User?>(
            builder: (context, state) {
              if (state == null) return const SizedBox.shrink();
              return SizeTransition(
                sizeFactor: _expandAnimation,
                axisAlignment: -1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountItem(
                      name: state.firstName,
                      fileId: state.profilePhoto?.id,
                      miniThumb: state.profilePhoto?.minithumbnail?.data,
                      isCurrent: true,
                      onTap: () {
                        // maybe view profile or show dialog
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        // add new account
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Row(
                          children: [
                            const Icon(Icons.add, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              'Add Account',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1, thickness: 0.4),
                  ],
                ),
              );
            },
          ),

          /// Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                _DrawerItem(icon: CupertinoIcons.person, title: 'My Profile'),
                Divider(height: 1, thickness: 0.4),
                _DrawerItem(icon: CupertinoIcons.group, title: 'New Group'),
                _DrawerItem(icon: Icons.contacts_outlined, title: 'Contacts'),
                _DrawerItem(icon: CupertinoIcons.phone, title: 'Calls'),
                _DrawerItem(icon: CupertinoIcons.bookmark, title: 'Saved Messages'),
                _DrawerItem(icon: CupertinoIcons.settings, title: 'Settings'),
                Divider(height: 1, thickness: 0.4),
                _DrawerItem(icon: CupertinoIcons.person_add, title: 'Invite Friends'),
                _DrawerItem(icon: Icons.help_outline, title: 'Telegram Features'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// DrawerItem: Custom clickable item
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 20, color: isDark ? Colors.white70 : Colors.black87),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AccountItem: Used in account switching
class AccountItem extends StatelessWidget {
  final String name;
  final String? miniThumb;
  final int? fileId;
  final bool isCurrent;
  final VoidCallback onTap;

  const AccountItem({
    super.key,
    required this.name,
    this.miniThumb,
    this.fileId,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                AvatarWidget(
                  miniThumb: miniThumb,
                  fileId: fileId,
                  radius: 18,
                ),
                if (isCurrent)
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0.5),
                      child: Icon(Icons.check_circle, size: 14, color: Colors.green),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}