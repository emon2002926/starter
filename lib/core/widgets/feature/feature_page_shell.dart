import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';

class FeaturePageShell extends StatelessWidget {
  const FeaturePageShell({
    super.key,
    required this.child,
    this.primaryGlowColor,
    this.secondaryGlowColor,
  });

  final Widget child;
  final Color? primaryGlowColor;
  final Color? secondaryGlowColor;

  @override
  Widget build(BuildContext context) {
    final primary = primaryGlowColor ?? AppColors.brandBlue;
    final secondary = secondaryGlowColor ?? AppColors.practiceTeal;

    return Scaffold(
      backgroundColor: AppColors.screenBgBottom,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.screenBgTop,
              AppColors.screenBgBottom,
              AppColors.white,
            ],
            stops: [0, 0.55, 1],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -context.h(36),
              right: -context.w(48),
              child: _GlowOrb(
                size: context.w(210),
                color: primary.withValues(alpha: 0.16),
              ),
            ),
            Positioned(
              top: context.h(280),
              left: -context.w(70),
              child: _GlowOrb(
                size: context.w(170),
                color: secondary.withValues(alpha: 0.1),
              ),
            ),
            Positioned(
              bottom: context.h(80),
              right: -context.w(40),
              child: _GlowOrb(
                size: context.w(140),
                color: primary.withValues(alpha: 0.07),
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
