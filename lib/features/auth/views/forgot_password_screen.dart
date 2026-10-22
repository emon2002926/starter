import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/feature/feature_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
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
                                  Container(
                                    padding: EdgeInsets.all(context.w(10)),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(context.w(10)),
                                    ),
                                    child: Icon(
                                      Icons.key_rounded,
                                      color: const Color(0xFF2563EB),
                                      size: context.sp(22),
                                    ),
                                  ),
                                  SizedBox(height: context.h(16)),
                                  AppText(
                                    data: 'Forgot password?',
                                    textAlign: TextAlign.center,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.ink,
                                    latterSpacing: -0.5,
                                  ),
                                  SizedBox(height: context.h(8)),
                                  AppText(
                                    data: 'Enter your work email and we\'ll send a 6-digit OTP to verify your identity.',
                                    textAlign: TextAlign.center,
                                    fontSize: 13,
                                    color: AppColors.muted,
                                    height: 1.5,
                                  ),
                                  SizedBox(height: context.h(32)),
                                  AppTextField(
                                    label: 'Email',
                                    hintText: 'sarah.j@averymarsh.com',
                                    controller: controller.emailController,
                                    focusNode: controller.emailFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icons.mail_outline_rounded,

                                  ),
                                  SizedBox(height: context.h(28)),
                                  Obx(
                                    () => AppButton(
                                      buttonText: 'Send OTP Code',
                                      isLoading: controller.isLoading.value,
                                      onPressed: controller.onSubmitTap,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
