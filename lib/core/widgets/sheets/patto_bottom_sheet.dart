import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';

/// Shared bottom-sheet chrome matching v112 (`border-radius: 24px` + drag handle).
class PattoBottomSheet extends StatelessWidget {
  const PattoBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.showHandle = true,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool showHandle;

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.cream,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle) ...[
            SizedBox(height: context.h(12)),
            Container(
              width: context.w(40),
              height: context.h(4),
              decoration: BoxDecoration(
                color: AppColors.creamDarker,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }
}
