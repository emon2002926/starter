
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../util/screen_size.dart';
import '../buttons/app_button.dart';
import '../text/app_text.dart';


class PremiumPaywallSheet extends StatefulWidget {
  const PremiumPaywallSheet._();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PremiumPaywallSheet._(),
    );
  }

  @override
  State<PremiumPaywallSheet> createState() => _PremiumPaywallSheetState();
}

class _PremiumPaywallSheetState extends State<PremiumPaywallSheet> {
  bool _isYearly = true;

  static const _green = AppColors.premiumGreen;
  static const _teal = AppColors.successDeep;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(
          context.w(10),
          context.h(10),
          context.w(10),
          context.h(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: context.w(40),
                height: context.h(4),
                margin: EdgeInsets.only(bottom: context.h(12)),
                decoration: BoxDecoration(
                  color: AppColors.creamDarker,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: context.w(28),
                  height: context.w(28),
                  decoration: const BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),

            Image.asset(
              height: context.w(150),
              width: context.h(150),
              'assets/images/drawer_image.png',
              fit: BoxFit.contain,
            ),


             AppText(
              data: "You've reached your free limit",
              fontSize: context.sp(20),
              fontWeight: FontWeight.w700,
              color: _teal,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.h(8)),
            const AppText(
              data: 'Continue your skincare analysis with SkinSeek Premium.\nUnlock unlimited insights tailored to your skin',
              fontSize: 14,
              color: AppColors.titleTextColor,
              textAlign: TextAlign.center,
              height: 1.6,

            ),
            SizedBox(height: context.h(10)),

            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  'Unlimited ingredient analysis',
                  'Personalised skincare routines',
                  'Advanced ingredient insights',
                  'Smarter product recommendations',
                ].map(
                      (text) => Padding(
                    padding: EdgeInsets.only(bottom: context.h(10)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: context.w(22),
                          height: context.w(22),
                          decoration: const BoxDecoration(
                            color: _green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                        SizedBox(width: context.w(12)),
                        AppText(
                          data: text,
                          fontSize: 14,
                          color: AppColors.bodyTextAlt,
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),



            SizedBox(height: context.h(20)),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _PlanCard(
                      label: 'Monthly',
                      price: '£2.99',
                      sub: '/per month',
                      isSelected: !_isYearly,
                      onTap: () => setState(() => _isYearly = false),
                    ),
                  ),
                  SizedBox(width: context.w(10)),
                  Expanded(
                    child: _PlanCard(
                      label: 'Yearly',
                      price: '£19.99',
                      sub: '/per year',
                      badge: 'Most popular',
                      note: '£1.67 per month',
                      isSelected: _isYearly,
                      onTap: () => setState(() => _isYearly = true),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.h(20)),
            AppButton(
              buttonText: 'Upgrade to premium',
              onPressed: () {},
              fillColor: _green,
              textColor: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              buttonHeight: 54,
              borderRadius: 32,
            ),
            SizedBox(height: context.h(14)),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const AppText(
                data: 'Maybe later',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String label;
  final String price;
  final String sub;
  final String? badge;
  final String? note;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.label,
    required this.price,
    required this.sub,
    this.badge,
    this.note,
    required this.isSelected,
    required this.onTap,
  });

  static const _green = AppColors.premiumGreen;
  static const _bg = AppColors.premiumCardBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.w(12),
              vertical: context.h(20),
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.successBackgroundSoft : Colors.white,
              borderRadius: BorderRadius.circular(context.w(16)),
              border: Border.all(
                color: isSelected ? _green : AppColors.borderPale,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  data: label,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.successDeep,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.h(6)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: AppFonts.outfit,
                      color: AppColors.bodyTextAlt,
                    ),
                    children: [
                      TextSpan(
                        text: price,
                        style: TextStyle(
                          fontFamily: AppFonts.outfit,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: sub,
                        style: TextStyle(
                            fontFamily: AppFonts.outfit, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (note != null) ...[
                  SizedBox(height: context.h(4)),
                  AppText(
                    data: note!,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _green,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -13,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w(14),
                    vertical: context.h(4),
                  ),
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const AppText(
                    data: 'Most popular',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}