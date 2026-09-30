import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../util/app_navigation.dart';
import '../../util/screen_size.dart';

class FeatureAppBar extends StatelessWidget {
  const FeatureAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.trailing,
    this.onBack,
  });

  final String title;
  final bool centerTitle;
  final Widget? trailing;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(12),
        context.h(6),
        context.w(12),
        context.h(10),
      ),
      child: Row(
        children: [
          FeatureIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: onBack ?? () => AppNavigation.pop(null, context),
          ),
          if (centerTitle) ...[
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: context.sp(17),
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            trailing ?? SizedBox(width: context.w(46)),
          ] else ...[
            SizedBox(width: context.w(12)),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: context.sp(18),
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            ?trailing,
          ],
        ],
      ),
    );
  }
}

class FeatureIconButton extends StatelessWidget {
  const FeatureIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.w(14)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: AppColors.white.withValues(alpha: 0.72),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: context.w(46),
              height: context.w(46),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.w(14)),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.85),
                ),
              ),
              child: Icon(icon, size: context.sp(22), color: AppColors.ink),
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureQuietLabel extends StatelessWidget {
  const FeatureQuietLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.plusJakartaSans(
        fontSize: context.sp(11),
        fontWeight: FontWeight.w800,
        color: AppColors.brandBlueDeep.withValues(alpha: 0.7),
        letterSpacing: 1.6,
      ),
    );
  }
}
