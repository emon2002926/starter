import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';

/// Primary CTA button — matches v112 `.btn` press: scale ~0.97 and slight fade.
class AppButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final double? buttonHeight;
  final double? buttonWidth;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FontWeight? fontWeight;
  final bool isLoading;
  final String? loadingText;
  final double? elevation;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool useResponsiveSize;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.buttonHeight,
    this.buttonWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.fontWeight,
    this.isLoading = false,
    this.loadingText,
    this.elevation,
    this.fillColor,
    this.borderColor,
    this.borderWidth,
    this.useResponsiveSize = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();

  // ── Loading Overlay ───────────────────────────────────────────────────────
  static Widget buildLoadingOverlay({
    required RxBool isLoading,
    required String loadingMessage,
    Color? backgroundColor,
    Color? cardColor,
  }) {
    return Obx(
      () => isLoading.value
          ? Container(
              color: (backgroundColor ?? Colors.black).withValues(alpha: 0.5),
              child: Center(
                child: Builder(
                  builder: (context) => Container(
                    padding: EdgeInsets.all(context.w(24)),
                    margin: EdgeInsets.symmetric(horizontal: context.w(40)),
                    decoration: BoxDecoration(
                      color:
                          cardColor ?? AppColors.loadingOverlayCardBackground,
                      borderRadius: BorderRadius.circular(context.w(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: context.w(40),
                          width: context.w(40),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                AppColors.loadingOverlayPurple),
                            strokeWidth: 3,
                          ),
                        ),
                        SizedBox(height: context.h(20)),
                        Text(
                          loadingMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.sp(16),
                            fontWeight: FontWeight.w500,
                            color: AppColors.loadingOverlayText,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  static const _pressScale = 0.97;
  static const _pressOpacity = 0.85;
  static const _pressDuration = Duration(milliseconds: 140);

  @override
  Widget build(BuildContext context) {
    // Client tokens: 52px height, 16px radius, 15px / w600 label.
    final double resolvedRadius = widget.useResponsiveSize
        ? context.w(widget.borderRadius ?? 16)
        : (widget.borderRadius ?? 16);

    final double resolvedHeight = widget.useResponsiveSize
        ? context.h(widget.buttonHeight ?? 52)
        : (widget.buttonHeight ?? 52);

    final double resolvedFontSize = widget.useResponsiveSize
        ? context.sp(widget.fontSize ?? 15)
        : (widget.fontSize ?? 15);

    final double resolvedIconSize = widget.useResponsiveSize
        ? context.sp(widget.fontSize ?? 24)
        : (widget.fontSize ?? 24);

    final bool isDisabled = widget.onPressed == null || widget.isLoading;
    final Color baseFill = widget.fillColor ?? AppColors.buttonFillColor;
    final bool isRoseFill = baseFill == AppColors.buttonFillColor ||
        baseFill == AppColors.buttonFillColor ||
        baseFill == AppColors.blue2_50;
    final Color resolvedFill = (!isDisabled && _pressed && isRoseFill)
        ? AppColors.buttonFillColor
        : baseFill;

    return SizedBox(
      width: widget.buttonWidth ?? double.infinity,
      height: resolvedHeight,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1.0,
        child: AnimatedScale(
          scale: (!isDisabled && _pressed) ? _pressScale : 1.0,
          duration: _pressDuration,
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: (!isDisabled && _pressed) ? _pressOpacity : 1.0,
            duration: _pressDuration,
            curve: Curves.easeOut,
            child: Listener(
              onPointerDown: isDisabled
                  ? null
                  : (_) => setState(() => _pressed = true),
              onPointerUp: isDisabled
                  ? null
                  : (_) => setState(() => _pressed = false),
              onPointerCancel: isDisabled
                  ? null
                  : (_) => setState(() => _pressed = false),
              child: Container(
                decoration: BoxDecoration(
                  color: resolvedFill,
                  borderRadius: BorderRadius.circular(resolvedRadius),
                  border: Border.all(
                    color: widget.borderColor ?? Colors.transparent,
                    width: widget.borderWidth ?? 0,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: isDisabled ? null : widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: widget.elevation ?? 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(resolvedRadius),
                    ),
                    padding: EdgeInsets.zero,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  child: widget.isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: context.h(20),
                              width: context.w(20),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    widget.textColor ?? Colors.white),
                                strokeWidth: 2.5,
                              ),
                            ),
                            if (widget.loadingText != null) ...[
                              SizedBox(width: context.w(12)),
                              Text(
                                widget.loadingText!,
                                style: TextStyle(
                                  color: widget.textColor ?? Colors.white,
                                  fontSize: resolvedFontSize,
                                  fontWeight:
                                      widget.fontWeight ?? FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.prefixIcon != null) ...[
                              Icon(widget.prefixIcon,
                                  color: widget.textColor ?? Colors.white,
                                  size: resolvedIconSize),
                              SizedBox(width: context.w(8)),
                            ],
                            AppText(
                              data: widget.buttonText,
                              color: widget.textColor ?? Colors.white,
                              fontSize: widget.fontSize ?? 15,
                              fontWeight:
                                  widget.fontWeight ?? FontWeight.w600,
                              useResponsiveFontSize: widget.useResponsiveSize,
                            ),
                            if (widget.suffixIcon != null) ...[
                              SizedBox(width: context.w(8)),
                              Icon(widget.suffixIcon,
                                  color: widget.textColor ?? Colors.white,
                                  size: resolvedIconSize),
                            ],
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
