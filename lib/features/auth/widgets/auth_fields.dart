import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';

/// Light-theme wrapper around [AppTextField] for auth screens.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.label2,
    this.onLabel2Tap,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? label2;
  final VoidCallback? onLabel2Tap;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      label2: label2,
      label2OnClick: onLabel2Tap,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconTap: onSuffixTap,
      fillColor: AppColors.white,
      inputTextColor: AppColors.ink,
      hintTextColor: AppColors.muted,
      borderColor: AppColors.uiBorder,
      focusedErrorBorderColor: const Color(0xFF2563EB),
      customBorderRadius: BorderRadius.circular(context.w(10)),
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.h(52),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF2563EB), // Solid blue color matching design
          borderRadius: BorderRadius.circular(context.w(10)), // the design has slightly squarer corners (looks like 10)
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2563EB).withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(context.w(10)),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: context.sp(22),
                      height: context.sp(22),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.white,
                      ),
                    )
                  : AppText(
                      data: label,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      googleFontFamily: GoogleFonts.plusJakartaSans,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onTap,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prompt.isNotEmpty) ...[
          AppText(
            data: prompt,
            fontSize: 14,
            color: AppColors.muted,
            googleFontFamily: GoogleFonts.plusJakartaSans,
          ),
          SizedBox(width: context.w(6)),
        ],
        GestureDetector(
          onTap: onTap,
          child: AppText(
            data: action,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.brandBlue,
            googleFontFamily: GoogleFonts.plusJakartaSans,
          ),
        ),
      ],
    );
  }
}
