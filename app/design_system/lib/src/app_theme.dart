import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8F8F8),
    primaryColor: const Color(0xFF0088CC),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0088CC), // Telegram blue
      secondary: Color(0xFF60B0EA),
      surface: Colors.white,
      background: Color(0xFFF8F8F8),
      error: Color(0xFFE53935),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      outline: Color(0xFFE0E0E0),
      surfaceVariant: Color(0xFFF5F5F5),
      onSurfaceVariant: Color(0xFF666666),
    ),
    // Text Theme
    textTheme: const TextTheme(
      headlineLarge: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'RobotoCondensed-Regular',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF999999),
      ),
      labelLarge: const TextStyle(
        fontFamily: 'RobotoMono-Bold',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelSmall: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFF999999),
      ),
    ),

    fontFamily: 'Roboto',

    // Icon Theme
    iconTheme: const IconThemeData(
      color: Color(0xFF474D50),
      size: 24,
    ),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF), // oq rang, oddiy light background
      foregroundColor: Colors.black,
      elevation: 0,
      shadowColor: Color(0x1A000000),
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'RobotoCondensed', // Telegram'ga o‘xshatildi
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF0088CC), // Telegram primary blue
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF0088CC),
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F5F5), // biroz engilroq kulrang fon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // Telegram'da ancha yumaloq emas
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF0088CC), // Telegram blue
          width: 1.8,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE53935),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE53935),
          width: 2,
        ),
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF999999),
        fontFamily: 'Roboto',
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF666666),
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0088CC), // Telegram blue
        foregroundColor: Colors.white,
        elevation: 0, // Telegramda shadow yo‘q
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Telegramda deyarli pillapoya
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0088CC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF0088CC),
        side: const BorderSide(
          color: Color(0xFF0088CC),
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0088CC),
      foregroundColor: Colors.white,
      elevation: 0, // Telegramda hech qanday soyalar yo‘q
      shape: CircleBorder(),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    ),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      selectedTileColor: Color(0xFFE3F2FD),
      iconColor: Color(0xFF0088CC),
      textColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF0088CC),
      unselectedItemColor: Color(0xFF8E8E93),
      selectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0, // Telegramda soyasiz, app bar ichida joylashgan
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xFF0088CC),
      unselectedLabelColor: Color(0xFF8E8E93),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Color(0xFF0088CC),
          width: 2,
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF0088CC);
        }
        return const Color(0xFFC7C7CC);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0x6688DDEE); // Telegramda shaffof ko‘k
        }
        return const Color(0xFFE5E5EA);
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF0088CC);
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: const BorderSide(
        color: Color(0xFF0088CC),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF0088CC);
        }
        return const Color(0xFF8E8E93);
      }),
    ),

    // Slider Theme
    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(0xFF0088CC),
      inactiveTrackColor: Color(0xFFD1D1D6),
      thumbColor: Color(0xFF0088CC),
      overlayColor: Color(0x330088CC),
      valueIndicatorColor: Colors.transparent,
      showValueIndicator: ShowValueIndicator.never,
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
      space: 0,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF2F2F7),
      selectedColor: const Color(0xFF0088CC),
      secondarySelectedColor: const Color(0xFF60B0EA),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      labelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide.none,
      ),
    ),

    // Snackbar Theme
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF323232),
      contentTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: Colors.white,
      ),
      actionTextColor: Color(0xFF0088CC),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF0088CC),
      linearTrackColor: Color(0xFFE0E0E0),
      circularTrackColor: Color(0xFFE0E0E0),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1D2733),
    primaryColor: const Color(0xFF60B0EA),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0088CC),
      secondary: Color(0xFF60B0EA),
      surface: Color(0xFF1F1F1F),
      background: Color(0xFF121212),
      error: Color(0xFFCF6679),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      outline: Color(0xFF2E2E2E),
      surfaceVariant: Color(0xFF2A2A2A),
      onSurfaceVariant: Color(0xFFB3B3B3),
    ),

    // Text Theme

    textTheme: const TextTheme(
      headlineLarge: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'RobotoCondensed-Bold',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'RobotoCondensed-Regular',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFFB0B0B0),
      ),
      labelLarge: const TextStyle(
        fontFamily: 'RobotoMono-Bold',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: const TextStyle(
        fontFamily: 'RobotoMono-Regular',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFFAAAAAA),
      ),
    ),

    fontFamily: 'Roboto',

    // Icon Theme
    iconTheme: const IconThemeData(
      color: Color(0xFF60B0EA), // Primary blue
      size: 24,
    ),

    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1D2733), // Dark background
      foregroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF60B0EA),
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF60B0EA),
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color(0xFF60B0EA),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color(0xFFCF6679),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color(0xFFCF6679),
          width: 2,
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: Color(0xFFB3B3B3),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF60B0EA),
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: const Color(0x1AFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF60B0EA),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF60B0EA),
        side: const BorderSide(
          color: Color(0xFF60B0EA),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF60B0EA),
      foregroundColor: Colors.white,
      elevation: 6,
      shape: CircleBorder(),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFF2A2A2A),
      shadowColor: const Color(0x1AFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    ),

    // List Tile Theme
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFF2A2A2A),
      selectedTileColor: Color(0xFF1A73E8),
      iconColor: Color(0xFF60B0EA),
      textColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: Color(0xFFB3B3B3),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF2A2A2A),
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: const Color(0x1AFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        color: Colors.white,
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      selectedItemColor: Color(0xFF60B0EA),
      unselectedItemColor: Color(0xFFB3B3B3),
      selectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Tab Bar Theme
    tabBarTheme: const TabBarTheme(
      labelColor: Color(0xFF60B0EA),
      unselectedLabelColor: Color(0xFFB3B3B3),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Color(0xFF60B0EA),
          width: 2,
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF60B0EA);
        }
        return const Color(0xFF888888);
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF1A73E8);
        }
        return const Color(0xFF444444);
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF60B0EA);
        }
        return const Color(0xFF888888);
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: const BorderSide(color: Color(0xFF60B0EA)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF60B0EA);
        }
        return const Color(0xFF888888);
      }),
    ),

    // Slider Theme
    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(0xFF60B0EA),
      inactiveTrackColor: Color(0xFF3A3A3A),
      thumbColor: Color(0xFF60B0EA),
      overlayColor: Color(0x1A60B0EA),
      valueIndicatorColor: Color(0xFF60B0EA),
      valueIndicatorTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFF3A3A3A),
      thickness: 1,
      space: 1,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF242424),
      selectedColor: const Color(0xFF60B0EA),
      secondarySelectedColor: const Color(0xFF1A73E8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF3A3A3A),
      contentTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      actionTextColor: Color(0xFF60B0EA),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF60B0EA),
      linearTrackColor: Color(0xFF3A3A3A),
      circularTrackColor: Color(0xFF3A3A3A),
    ),
  );
}

class AppColors {
  // === Light Theme ===
  static const Color lightPrimary = Color(0xFF0088CC);
  static const Color lightSecondary = Color(0xFF60B0EA);
  static const Color lightBackground = Color(0xFFF0F0F0);
  static const Color lightSurface = Colors.white;
  static const Color lightError = Color(0xFFE53935);
  static const Color lightOnPrimary = Colors.white;
  static const Color lightOnSecondary = Colors.white;
  static const Color lightOnBackground = Colors.black;
  static const Color lightOnSurface = Colors.black;
  static const Color lightOnError = Colors.white;

  // === Dark Theme ===
  static const Color darkPrimary = Color(0xFF222D3D);
  static const Color darkSecondary = Color(0xFF1A73E8);
  static const Color darkBackground = Color(0xFF1D2733);
  static const Color darkSurface = Color(0xFF1D2733);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnPrimary = Colors.white;
  static const Color darkOnSecondary = Colors.white;
  static const Color darkOnBackground = Colors.white;
  static const Color darkOnSurface = Colors.white;
  static const Color darkOnError = Colors.white;

  // === Message Bubble Colors ===
  static const Color myMessageLight = Color(0xFFDCF8C6); // Telegram'dagi sender bg
  static const Color otherMessageLight = Color(0xFFFFFFFF);
  static const Color myMessageDark = Color(0xFF2C3A4B); // Telegram dark sender bg
  static const Color otherMessageDark = Color(0xFF2A2A2A);

  // === Status & Activity Colors ===
  static const Color online = Color(0xFF4CAF50);
  static const Color away = Color(0xFFFF9800);
  static const Color busy = Color(0xFFE53935);
  static const Color offline = Color(0xFF9E9E9E);

  // === Message Highlight Colors (for reactions, replies, mentions, etc.) ===
  static const Color highlightGreen = Color(0xFF4CAF50);
  static const Color highlightBlue = Color(0xFF2196F3);
  static const Color highlightGrey = Color(0xFF9E9E9E);
  static const Color highlightRed = Color(0xFFE53935);
  static const Color highlightOrange = Color(0xFFFF9800);
  static const Color highlightPurple = Color(0xFF9C27B0);
  static const Color highlightTeal = Color(0xFF009688);
  static const Color highlightPink = Color(0xFFE91E63);

  // === Neutral UI Colors ===
  static const Color divider = Color(0xFFE0E0E0);
  static const Color lightOverlay = Color(0x1A000000);
  static const Color darkOverlay = Color(0x1AFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceVariantDark = Color(0xFF3A3A3A);
}

// Custom Text Styles for Telegram-like UI
class AppTextStyles {
// === Light Theme ===
  static const TextStyle lightChatTitle = TextStyle(
    fontFamily: 'RobotoCondensed-Bold',
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle lightChatSubtitle = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 14,
    color: Color(0xFF777777),
  );

  static const TextStyle lightChatMessage = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 16,
    color: Colors.black,
  );

  static const TextStyle lightChatTime = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 12,
    color: Color(0xFF999999),
  );

  static const TextStyle lightChatMessageMy = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle lightChatTimeMy = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 10,
    color: Color(0xFFCCCCCC),
  );

// === Dark Theme ===
  static const TextStyle darkChatTitle = TextStyle(
    fontFamily: 'RobotoCondensed-Bold',
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle darkChatSubtitle = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 14,
    color: Color(0xFFB0B0B0),
  );

  static const TextStyle darkChatMessage = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 10,
    color: Colors.white,
  );

  static const TextStyle darkChatTime = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 12,
    color: Color(0xFFAAAAAA),
  );

  static const TextStyle darkChatMessageMy = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle darkChatTimeMy = TextStyle(
    fontFamily: 'RobotoMono-Regular',
    fontSize: 12,
    color: Color(0xFFCCCCCC),
  );

// === Common ===
  static const TextStyle usernameLight = TextStyle(
    fontFamily: 'RobotoCondensed-Bold',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Color(0xFF0088CC),
  );

  static const TextStyle usernameDark = TextStyle(
    fontFamily: 'RobotoCondensed-Bold',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Color(0xFF60B0EA),
  );
}

// Custom Decorations for Telegram-like UI
class AppDecorations {
  // Message bubble decorations
  static BoxDecoration myMessageBubbleLight = BoxDecoration(
    color: AppColors.myMessageLight,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
      bottomRight: Radius.circular(4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static BoxDecoration otherMessageBubbleLight = BoxDecoration(
    color: AppColors.otherMessageLight,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(18),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static BoxDecoration myMessageBubbleDark = BoxDecoration(
    color: AppColors.myMessageDark,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
      bottomRight: Radius.circular(4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.1),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static BoxDecoration otherMessageBubbleDark = BoxDecoration(
    color: AppColors.otherMessageDark,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(18),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.1),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  // Chat list item decoration
  static BoxDecoration chatListItemLight = BoxDecoration(
    color: Colors.white,
    border: Border(
      bottom: BorderSide(
        color: Colors.grey.withOpacity(0.2),
        width: 0.5,
      ),
    ),
  );

  static BoxDecoration chatListItemDark = BoxDecoration(
    color: const Color(0xFF2A2A2A),
    border: Border(
      bottom: BorderSide(
        color: Colors.white.withOpacity(0.1),
        width: 0.5,
      ),
    ),
  );

  // Avatar decorations
  static BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Input field decoration
  static BoxDecoration inputFieldLight = BoxDecoration(
    color: const Color(0xFFF0F0F0),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.transparent,
      width: 1,
    ),
  );

  static BoxDecoration inputFieldDark = BoxDecoration(
    color: const Color(0xFF2A2A2A),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: Colors.transparent,
      width: 1,
    ),
  );

  // Focused input field decoration
  static BoxDecoration inputFieldFocusedLight = BoxDecoration(
    color: const Color(0xFFF0F0F0),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: const Color(0xFF0088CC),
      width: 2,
    ),
  );

  static BoxDecoration inputFieldFocusedDark = BoxDecoration(
    color: const Color(0xFF2A2A2A),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: const Color(0xFF60B0EA),
      width: 2,
    ),
  );
}

// Custom Dimensions for consistent spacing
class AppDimensions {
  // Padding
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  // Margins
  static const double marginSmall = 4.0;
  static const double marginMedium = 8.0;
  static const double marginLarge = 16.0;
  static const double marginExtraLarge = 24.0;

  // Border radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 24.0;
  static const double radiusCircular = 50.0;

  // Icon sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;

  // Avatar sizes
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 48.0;
  static const double avatarLarge = 64.0;
  static const double avatarExtraLarge = 96.0;

  // Button heights
  static const double buttonSmall = 32.0;
  static const double buttonMedium = 48.0;
  static const double buttonLarge = 56.0;

  // Chat specific dimensions
  static const double chatAvatarSize = 40.0;
  static const double chatListItemHeight = 72.0;
  static const double messageBubbleMaxWidth = 280.0;
  static const double messageInputHeight = 48.0;
}

// Animation durations for smooth transitions
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);

  // Specific animations
  static const Duration messageAnimation = Duration(milliseconds: 200);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration dialogAnimation = Duration(milliseconds: 250);
  static const Duration snackbarAnimation = Duration(milliseconds: 300);
  static const Duration buttonPress = Duration(milliseconds: 100);
}

// Custom gradients for additional visual appeal
class AppGradients {
  static const LinearGradient primaryGradientLight = LinearGradient(
    colors: [Color(0xFF0088CC), Color(0xFF60B0EA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradientDark = LinearGradient(
    colors: [Color(0xFF60B0EA), Color(0xFF1A73E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradientLight = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F8F8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient backgroundGradientDark = LinearGradient(
    colors: [Color(0xFF1C1C1C), Color(0xFF2A2A2A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

