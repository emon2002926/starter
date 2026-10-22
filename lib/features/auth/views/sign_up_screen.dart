import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/feature/feature_app_bar.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

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
                                  AppText(
                                    data: 'Create account',
                                    textAlign: TextAlign.center,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.ink,
                                    latterSpacing: -0.5,
                                  ),
                                  SizedBox(height: context.h(8)),
                                  AppText(
                                    data: 'Create a new account with email',
                                    textAlign: TextAlign.center,
                                    fontSize: 13,
                                    color: AppColors.muted,
                                    height: 1.5,
                                  ),
                                  SizedBox(height: context.h(32)),
                                  AppTextField(
                                    label: 'Full name',
                                    hintText: 'Enter your name',
                                    controller: controller.nameController,
                                    focusNode: controller.nameFocus,
                                    prefixIcon: Icons.person_outline_rounded,
                                  ),
                                  SizedBox(height: context.h(16)),
                                  AppTextField(
                                    label: 'Email',
                                    hintText: 'name@example.com',
                                    controller: controller.emailController,
                                    focusNode: controller.emailFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icons.mail_outline_rounded,
                                  ),
                                  SizedBox(height: context.h(16)),
                                  Obx(
                                    () => AppTextField(
                                      label: 'Password',
                                      hintText: 'At least 8 characters',
                                      controller: controller.passwordController,
                                      focusNode: controller.passwordFocus,
                                      obscureText: controller.obscurePassword.value,
                                      prefixIcon: Icons.lock_outline_rounded,
                                      suffixIcon: controller.obscurePassword.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      onSuffixIconTap: controller.togglePassword,
                                    ),
                                  ),
                                  SizedBox(height: context.h(16)),
                                  Obx(
                                    () => AppTextField(
                                      label: 'Confirm password',
                                      hintText: 'Re-enter password',
                                      controller: controller.confirmController,
                                      focusNode: controller.confirmFocus,
                                      obscureText: controller.obscureConfirm.value,
                                      prefixIcon: Icons.lock_outline_rounded,
                                      suffixIcon: controller.obscureConfirm.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      onSuffixIconTap: controller.toggleConfirm,
                                    ),
                                  ),
                                  SizedBox(height: context.h(28)),
                                  Obx(
                                    () => AppButton(
                                      buttonText: 'Continue',
                                      isLoading: controller.isLoading.value,
                                      onPressed: controller.onSubmitTap,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.h(24)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  data: 'Already have an account?',
                                  fontSize: 14,
                                  color: AppColors.muted,
                                ),
                                SizedBox(width: context.w(6)),
                                GestureDetector(
                                  onTap: () => AppNavigation.pop(null, context),
                                  child: AppText(
                                    data: 'Sign In',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.buttonFillColor,
                                  ),
                                ),
                              ],
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
