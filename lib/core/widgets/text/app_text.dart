import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';

// ─── Internal config holders ──────────────────────────────────────────────────

class _DisplayConfig {
  const _DisplayConfig({
    required this.size,
    required this.weight,
    required this.color,
    required this.height,
    required this.tracking,
  });
  final double size;
  final FontWeight weight;
  final Color color;
  final double height;
  final double tracking;
}

class _BodyConfig {
  const _BodyConfig({
    required this.size,
    required this.weight,
    required this.color,
  });
  final double size;
  final FontWeight weight;
  final Color color;
}

// ─── AppText ──────────────────────────────────────────────────────────────────

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.data,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.height,
    this.decoration,
    this.decorationColor,
    this.translate = false,
    this.frosted = false,
    this.latterSpacing,
    this.useResponsiveFontSize = true,
    this.fontFamily,
    this.googleFontFamily,
    this.style,
  })  : _displayConfig = null,
        _bodyConfig = null;

  // Private constructor used by named factories.
  const AppText._internal({
    super.key,
    required this.data,
    this.textScaleFactor = 0.9,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this._displayConfig,
    this._bodyConfig,
  })  : fontSize = 16, color = null, fontWeight = FontWeight.w400, height = null, decoration = null, decorationColor = null, translate = false, frosted = false, latterSpacing = null, useResponsiveFontSize = true, fontFamily = null, googleFontFamily = null, style = null;

  // ─── Named constructors ───────────────────────────────────────────────────

  /// Display-weight Plus Jakarta Sans text.
  ///
  /// Defaults: size 28 · w800 · [AppColors.ink] · height 1.15 · tracking −0.6.
  factory AppText.display(
    String data, {
    Key? key,
    double size = 28,
    FontWeight weight = FontWeight.w800,
    Color color = AppColors.ink,
    double height = 1.15,
    double tracking = -0.6,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    double textScaleFactor = 0.9,
  }) {
    return AppText._internal(
      key: key,
      data: data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      displayConfig: _DisplayConfig(
        size: size,
        weight: weight,
        color: color,
        height: height,
        tracking: tracking,
      ),
    );
  }

  /// Body-weight Plus Jakarta Sans text.
  ///
  /// Defaults: size 13 · w500 · [AppColors.muted].
  factory AppText.body(
    String data, {
    Key? key,
    double size = 13,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.muted,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    double textScaleFactor = 0.9,
  }) {
    return AppText._internal(
      key: key,
      data: data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      bodyConfig: _BodyConfig(size: size, weight: weight, color: color),
    );
  }

  // ─── Fields ───────────────────────────────────────────────────────────────

  final String data;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool translate;
  final bool frosted;
  final double? latterSpacing;
  final bool useResponsiveFontSize;
  /// Bundled font family name, e.g. `AppFonts.outfit`.
  final String? fontFamily;
  final TextStyle Function({TextStyle? textStyle})? googleFontFamily;
  final TextStyle? style;

  // Internal routing fields — only set by named factories.
  final _DisplayConfig? _displayConfig;
  final _BodyConfig? _bodyConfig;

  // ─── Style resolution ─────────────────────────────────────────────────────

  TextStyle _buildTextStyle(BuildContext context) {
    // Named-constructor fast paths
    if (_displayConfig != null) {
      final cfg = _displayConfig;
      return GoogleFonts.plusJakartaSans(
        fontSize: context.sp(cfg.size),
        fontWeight: cfg.weight,
        color: cfg.color,
        height: cfg.height,
        letterSpacing: cfg.tracking,
      );
    }

    if (_bodyConfig != null) {
      final cfg = _bodyConfig;
      return GoogleFonts.plusJakartaSans(
        fontSize: context.sp(cfg.size),
        fontWeight: cfg.weight,
        color: cfg.color,
      );
    }

    // Explicit style passthrough
    if (style != null) return style!;

    // ✅ Use ScreenSize extension sp() — already clamped for tablets
    final responsiveFontSize = useResponsiveFontSize && fontSize != null
        ? context.sp(fontSize!)
        : fontSize;

    TextStyle styleParams(TextStyle s) => s.copyWith(
      height: height,
      fontSize: responsiveFontSize,
      color: color ?? Colors.black,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: decorationColor,
      letterSpacing: latterSpacing,
    );

    if (googleFontFamily != null) {
      return styleParams(googleFontFamily!());
    }

    if (fontFamily != null) {
      return TextStyle(
        fontFamily: fontFamily,
        height: height,
        fontSize: responsiveFontSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
        letterSpacing: latterSpacing,
      );
    }

    return GoogleFonts.nunito(
      height: height,
      fontSize: responsiveFontSize,
      color: color ?? Colors.black,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: decorationColor,
      letterSpacing: latterSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      data,
      maxLines: maxLines ?? 20,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      style: _buildTextStyle(context),
      textScaler: TextScaler.linear(textScaleFactor),
    );

    if (!frosted) return textWidget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.w(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(8),
            vertical: context.h(4),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(context.w(10)),
          ),
          child: textWidget,
        ),
      ),
    );
  }
}