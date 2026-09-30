import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/feature/feature_app_bar.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.showBack = false,
    this.footer,
    this.icon,
    this.header,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final bool showBack;
  final Widget? footer;
  final IconData? icon;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light gray background
      body: SafeArea(
        child: Column(
          children: [
            if (showBack)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.w(12),
                  context.h(6),
                  context.w(12),
                  0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FeatureIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => AppNavigation.pop(null, context),
                  ),
                ),
              ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          context.w(24),
                          context.h(16),
                          context.w(24),
                          context.h(24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (header != null) ...[
                              header!,
                              SizedBox(height: context.h(32)),
                            ],
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.w(24),
                                vertical: context.h(32),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(context.w(16)),
                                border: Border.all(
                                  color: AppColors.uiBorder.withValues(alpha: 0.5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if (icon != null) ...[
                                    Container(
                                      padding: EdgeInsets.all(context.w(10)),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF6FF), // Light blue bg for icon
                                        borderRadius: BorderRadius.circular(context.w(10)),
                                      ),
                                      child: Icon(
                                        icon,
                                        color: const Color(0xFF2563EB), // Blue icon color
                                        size: context.sp(22),
                                      ),
                                    ),
                                    SizedBox(height: context.h(16)),
                                  ],
                                  Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: context.sp(22),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.ink,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(height: context.h(8)),
                                  Text(
                                    subtitle,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: context.sp(13),
                                      color: AppColors.muted,
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: context.h(32)),
                                  child,
                                ],
                              ),
                            ),
                            if (footer != null) ...[
                              SizedBox(height: context.h(24)),
                              footer!,
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
