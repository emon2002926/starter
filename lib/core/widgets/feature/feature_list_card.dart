import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';
import '../text/app_text.dart';


class FeatureSeparatedList extends StatelessWidget {
  const FeatureSeparatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.separatorHeight,
    this.header,
    this.footer,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final double? separatorHeight;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final gap = separatorHeight ?? context.h(12);
    final extra = (header != null ? 1 : 0) + (footer != null ? 1 : 0);

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: padding ??
          EdgeInsets.fromLTRB(
            context.w(20),
            context.h(8),
            context.w(20),
            context.h(28),
          ),
      itemCount: itemCount + extra,
      separatorBuilder: (_, _) => SizedBox(height: gap),
      itemBuilder: (context, index) {
        if (header != null && index == 0) return header!;
        final itemIndex = header != null ? index - 1 : index;
        if (itemIndex < itemCount) return itemBuilder(context, itemIndex);
        return footer!;
      },
    );
  }
}




class FeatureListCard extends StatelessWidget {
  const FeatureListCard({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.leadingLabel,
    this.leadingColor,
    this.leading,
    this.progress,
    this.progressLabel,
    this.selected = false,
    this.showChevron = true,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? leadingLabel;
  final Color? leadingColor;
  final Widget? leading;
  final double? progress;
  final String? progressLabel;
  final bool selected;
  final bool showChevron;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final radius = context.w(20);
    return Container(
      decoration: BoxDecoration(
        color: selected ? AppColors.brandBlueSoftAlt : AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: selected
              ? AppColors.brandBlue.withValues(alpha: 0.35)
              : AppColors.uiBorder.withValues(alpha: 0.7),
          width: selected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandBlue.withValues(alpha: selected ? 0.1 : 0.05),
            blurRadius: selected ? 18 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.w(14),
              vertical: context.h(14),
            ),
            child: Row(
              children: [
                if (selected) ...[
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.brandBlue,
                    size: context.sp(22),
                  ),
                  SizedBox(width: context.w(10)),
                ],
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: context.w(12)),
                ] else if (leadingLabel != null) ...[
                  FeatureBadge(
                    label: leadingLabel!,
                    color: leadingColor ?? AppColors.brandBlueSoft,
                  ),
                  SizedBox(width: context.w(12)),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: title,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                        maxLines: 3,
                        googleFontFamily: GoogleFonts.plusJakartaSans,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: context.h(4)),
                        AppText(
                          data: subtitle!,
                          fontSize: 13,
                          fontWeight: subtitleColor != null
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: subtitleColor ?? AppColors.muted,
                          googleFontFamily: GoogleFonts.plusJakartaSans,
                        ),
                      ],
                    ],
                  ),
                ),
                if (showChevron)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.muted.withValues(alpha: 0.65),
                    size: context.sp(22),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureBadge extends StatelessWidget {
  const FeatureBadge({
    super.key,
    required this.label,
    required this.color,
    this.foregroundColor,
  });

  final String label;
  final Color color;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w(48),
      height: context.w(48),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(context.w(14)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: context.sp(13),
          fontWeight: FontWeight.w800,
          color: foregroundColor ?? AppColors.ink,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}


