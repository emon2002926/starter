import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/sign_in_controller.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                              data: 'Welcome back',
                              textAlign: TextAlign.center,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.ink,
                              latterSpacing: -0.5,
                            ),
                            SizedBox(height: context.h(8)),
                            AppText(
                              data: 'Sign in to your construction workspace',
                              textAlign: TextAlign.center,
                              fontSize: 13,
                              color: AppColors.muted,
                              height: 1.5,
                            ),
                            SizedBox(height: context.h(32)),
                            AppTextField(
                              label: 'Work Email',
                              hintText: 'sarah.j@averymarsh.com',
                              controller: controller.emailController,
                              focusNode: controller.emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail_outline_rounded,
                            ),
                            SizedBox(height: context.h(16)),
                            Obx(
                              () => AppTextField(
                                label: 'Password',
                                hintText: '••••••••••••',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: true,
                                        onChanged: (val) {},
                                        activeColor: const Color(0xFF2563EB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    AppText(
                                      data: 'Remember me',
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => AppNavigation.push(
                                    const ForgotPasswordScreen(),
                                    context: context,
                                  ),
                                  child: AppText(
                                    data: 'Forgot password?',
                                    color: const Color(0xFF2563EB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: context.h(28)),
                            Obx(
                              () => AppButton(
                                buttonText: 'Sign In',
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
                            data: 'Don\'t have an account?',
                            fontSize: 14,
                            color: AppColors.muted,
                          ),
                          SizedBox(width: context.w(6)),
                          GestureDetector(
                            onTap: () => AppNavigation.push(
                              const SignUpScreen(),
                              context: context,
                            ),
                            child: AppText(
                              data: 'Sign Up',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.brandBlue,
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
    );
  }
}
