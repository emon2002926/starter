import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Modern green app theme — primary #4FAF5A.
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.brandBlue,
  scaffoldBackgroundColor: AppColors.screenBgBottom,
  canvasColor: AppColors.screenBgBottom,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brandBlue,
    primary: AppColors.brandBlue,
    secondary: AppColors.practiceTeal,
    surface: AppColors.white,
    error: AppColors.dangerBright,
    brightness: Brightness.light,
  ).copyWith(
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.ink,
    outline: AppColors.uiBorder,
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
    bodyColor: AppColors.ink,
    displayColor: AppColors.ink,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.ink,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: const IconThemeData(color: AppColors.brandBlueDeep),
    titleTextStyle: GoogleFonts.plusJakartaSans(
      fontSize: 17,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: const BorderSide(color: AppColors.uiBorder),
    ),
  ),
  iconTheme: const IconThemeData(color: AppColors.brandBlueDeep),
  dividerTheme: const DividerThemeData(
    color: AppColors.uiBorder,
    thickness: 1,
    space: 1,
  ),
  splashFactory: InkSparkle.splashFactory,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.brandBlue,
      foregroundColor: AppColors.white,
      elevation: 0,
      shadowColor: AppColors.brandBlue.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.brandBlue,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.brandBlueDeep,
      side: BorderSide(color: AppColors.brandBlue.withValues(alpha: 0.45)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandBlue,
    foregroundColor: AppColors.white,
    elevation: 4,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.uiBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.uiBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.brandBlue, width: 1.6),
    ),
    hintStyle: GoogleFonts.plusJakartaSans(
      color: AppColors.muted,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.brandBlue,
    unselectedItemColor: AppColors.navInactiveBlue,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.ink,
    contentTextStyle: GoogleFonts.plusJakartaSans(
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.brandBlue,
    linearTrackColor: AppColors.brandBlueSoft,
  ),
);
