import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';

/// Gradient hero header — home “Today’s Focus” energy.
class FeatureHeroCard extends StatelessWidget {
  const FeatureHeroCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badgeLabel,
    this.gradient = AppColors.heroGradient,
    this.shadowColor,
  });

  final String title;
  final String? subtitle;
  final String? badgeLabel;
  final List<Color> gradient;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final shadow = shadowColor ?? gradient.last;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.w(18)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.w(28)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: shadow.withValues(alpha: 0.32),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -context.w(20),
            top: -context.h(24),
            child: Container(
              width: context.w(110),
              height: context.w(110),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Row(
            children: [
              if (badgeLabel != null) ...[
                Container(
                  width: context.w(56),
                  height: context.w(56),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(context.w(18)),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.28),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badgeLabel!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(width: context.w(14)),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: title,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      maxLines: 2,
                      googleFontFamily: GoogleFonts.plusJakartaSans,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: context.h(4)),
                      AppText(
                        data: subtitle!,
                        fontSize: 13,
                        color: AppColors.white.withValues(alpha: 0.82),
                        googleFontFamily: GoogleFonts.plusJakartaSans,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Soft tinted mode / action card (home explore-tile feel).
class FeatureModeCard extends StatelessWidget {
  const FeatureModeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.softFill,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final Color softFill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: softFill,
      borderRadius: BorderRadius.circular(context.w(22)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.w(22)),
        child: Container(
          padding: EdgeInsets.all(context.w(14)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.w(22)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.85)),
          ),
          child: Row(
            children: [
              Container(
                width: context.w(46),
                height: context.w(46),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(context.w(14)),
                  boxShadow: [
                    BoxShadow(
                      color: gradient.last.withValues(alpha: 0.28),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: AppColors.white, size: context.sp(22)),
              ),
              SizedBox(width: context.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                      googleFontFamily: GoogleFonts.plusJakartaSans,
                    ),
                    SizedBox(height: context.h(2)),
                    AppText(
                      data: subtitle,
                      fontSize: 12,
                      color: AppColors.muted,
                      googleFontFamily: GoogleFonts.plusJakartaSans,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: gradient.last,
                size: context.sp(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
