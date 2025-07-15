import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

extension AppTextStyleExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  TextStyle get chatTitle =>
      isDark ? AppTextStyles.darkChatTitle : AppTextStyles.lightChatTitle;

  TextStyle get chatSubtitle =>
      isDark ? AppTextStyles.darkChatSubtitle : AppTextStyles.lightChatSubtitle;

  TextStyle get chatMessage =>
      isDark ? AppTextStyles.darkChatMessage : AppTextStyles.lightChatMessage;

  TextStyle get chatTime =>
      isDark ? AppTextStyles.darkChatTime : AppTextStyles.lightChatTime;

  TextStyle get chatMessageMy =>
      isDark ? AppTextStyles.darkChatMessageMy : AppTextStyles.lightChatMessageMy;

  TextStyle get chatTimeMy =>
      isDark ? AppTextStyles.darkChatTimeMy : AppTextStyles.lightChatTimeMy;

  TextStyle get username =>
      isDark ? AppTextStyles.usernameDark : AppTextStyles.usernameLight;
}