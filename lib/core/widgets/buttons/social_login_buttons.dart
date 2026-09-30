import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String? iconPath;
  final IconData? icon;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? iconColor;

  const SocialButton({
    super.key,
    required this.onTap,
    required this.text,
    this.iconPath,
    this.icon,
    required this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.iconColor,
  }) : assert(
          iconPath != null || icon != null,
          'Provide either iconPath or icon',
        );

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.creamDark;
    final fg = textColor ?? AppColors.buttonFillColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.responsiveSize(height),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              SizedBox(
                width: context.responsiveSize(15),
                height: context.responsiveSize(15),
                child: Image.asset(
                  iconPath!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Text(
                    'G',
                    style: TextStyle(
                      fontSize: context.responsiveSize(14),
                      fontWeight: FontWeight.w700,
                      color: AppColors.googleBlue,
                    ),
                  ),
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                color: iconColor ?? fg,
                size: context.responsiveSize(18),
              ),
            SizedBox(width: context.responsiveSize(9)),
            AppText(
              data: text,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: fg,
              useResponsiveFontSize: true,
              fontFamily: AppFonts.outfit,
            ),
          ],
        ),
      ),
    );
  }
}
