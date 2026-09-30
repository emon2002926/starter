import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../util/screen_size.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  final int currentIndex;
  final Function(int) onTabSelected;

  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.folder_outlined,
    Icons.auto_awesome_outlined,
    Icons.person_outline,
  ];

  static const List<IconData> _activeIcons = [
    Icons.home,
    Icons.folder,
    Icons.auto_awesome,
    Icons.person,
  ];

  static const List<String> _labelKeys = [
    'Home',
    'Projects',
    'Latti AI',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.uiBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70, // Fixed height for navbar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTab(context, 0),
              _buildTab(context, 1),
              // GestureDetector(
              //   onTap: () {
              //     showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       backgroundColor: Colors.transparent,
              //       builder: (context) => const CreateNewBottomSheet(),
              //     );
              //   },
              //   child: Container(
              //     width: 56,
              //     height: 56,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       gradient: const LinearGradient(
              //         colors: [Color(0xFF007AFF), Color(0xFF00C6FF)],
              //         begin: Alignment.bottomLeft,
              //         end: Alignment.topRight,
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: const Color(0xFF00C6FF).withValues(alpha: 0.3),
              //           blurRadius: 12,
              //           offset: const Offset(0, 4),
              //         ),
              //       ],
              //     ),
              //     child: const Icon(Icons.add, color: Colors.white, size: 28),
              //   ),
              // ),
              _buildTab(context, 2),
              _buildTab(context, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!isSelected) {
            HapticFeedback.selectionClick();
          }
          onTabSelected(index);
        },
        child: SizedBox(
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isSelected)
                Positioned(
                  top: 0,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF007AFF),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              _NavTabContent(
                icon: isSelected ? _activeIcons[index] : _icons[index],
                label: _labelKeys[index],
                isSelected: isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTabContent extends StatefulWidget {
  const _NavTabContent({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  State<_NavTabContent> createState() => _NavTabContentState();
}

class _NavTabContentState extends State<_NavTabContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pop;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.28), weight: 35),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.28,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 65,
      ),
    ]).animate(_pop);
    if (widget.isSelected) _pop.value = 1;
  }

  @override
  void didUpdateWidget(covariant _NavTabContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _pop.forward(from: 0);
    } else if (!widget.isSelected) {
      _pop.value = 0;
    }
  }

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.isSelected
        ? const Color(0xFF007AFF)
        : const Color(0xFF64748B);
    final labelColor = widget.isSelected
        ? const Color(0xFF007AFF)
        : const Color(0xFF64748B);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: context.h(36),
          child: Center(
            child: ScaleTransition(
              scale: _scale,
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(begin: iconColor, end: iconColor),
                duration: const Duration(milliseconds: 240),
                builder: (context, color, _) {
                  return Icon(widget.icon, size: context.sp(22), color: color);
                },
              ),
            ),
          ),
        ),
        SizedBox(height: context.h(4)),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 240),
          style: GoogleFonts.plusJakartaSans(
            fontSize: context.sp(11),
            fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
            color: labelColor,
          ),
          child: Text(widget.label),
        ),
      ],
    );
  }
}
