import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/otp_controller.dart';
import '../widgets/auth_fields.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/otp_input_row.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.isFromSignUp,
  });

  final String email;
  final bool isFromSignUp;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnterOtpController>();

    return AuthScaffold(
      showBack: true,
      title: 'Check your email',
      subtitle: 'We sent a 6-digit verification code to\n$email',
      icon: Icons.shield_outlined,
      child: Column(
        children: [
          OtpInputRow(
            length: 6,
            onChanged: (code) => controller.otpController.text = code,
            onCompleted: (code) {
              controller.otpController.text = code;
              controller.onSubmitTap(email, isFromSignUp);
            },
          ),
          SizedBox(height: context.h(28)),
          Obx(
            () => AuthPrimaryButton(
              label: 'Verify Code',
              isLoading: controller.isLoading.value,
              onTap: () => controller.onSubmitTap(email, isFromSignUp),
            ),
          ),
          SizedBox(height: context.h(20)),
          Obx(() {
            if (controller.canResend.value) {
              return GestureDetector(
                onTap: () => controller.onResendTap(email, isFromSignUp),
                child: AppText(
                  data: 'Resend code',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandBlue,
                  googleFontFamily: GoogleFonts.plusJakartaSans,
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  data: 'Resend code in ',
                  fontSize: 13,
                  color: AppColors.muted,
                  googleFontFamily: GoogleFonts.plusJakartaSans,
                ),
                AppText(
                  data: controller.formattedTime,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandBlue,
                  googleFontFamily: GoogleFonts.plusJakartaSans,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
