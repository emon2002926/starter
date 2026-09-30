 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/auth_fields.dart';
import '../widgets/auth_scaffold.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

    return AuthScaffold(
      showBack: true,
      title: 'Create account',
      subtitle: 'Create a new account with email',
      footer: AuthFooterLink(
        prompt: 'Already have an account?',
        action: 'Sign In',
        onTap: () => AppNavigation.pop(null, context),
      ),
      child: Column(
        children: [
          AuthTextField(
            label: 'Full name',
            hintText: 'Enter your name',
            controller: controller.nameController,
            focusNode: controller.nameFocus,
            prefixIcon: Icons.person_outline_rounded,
          ),
          SizedBox(height: context.h(16)),
          AuthTextField(
            label: 'Email',
            hintText: 'name@example.com',
            controller: controller.emailController,
            focusNode: controller.emailFocus,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline_rounded,
          ),
          SizedBox(height: context.h(16)),
          Obx(
            () => AuthTextField(
              label: 'Password',
              hintText: 'At least 8 characters',
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              obscureText: controller.obscurePassword.value,
              prefixIcon: Icons.lock_outline_rounded,
              suffixIcon: controller.obscurePassword.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              onSuffixTap: controller.togglePassword,
            ),
          ),
          SizedBox(height: context.h(16)),
          Obx(
            () => AuthTextField(
              label: 'Confirm password',
              hintText: 'Re-enter password',
              controller: controller.confirmController,
              focusNode: controller.confirmFocus,
              obscureText: controller.obscureConfirm.value,
              prefixIcon: Icons.lock_outline_rounded,
              suffixIcon: controller.obscureConfirm.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              onSuffixTap: controller.toggleConfirm,
            ),
          ),
          SizedBox(height: context.h(28)),
          Obx(
            () => AuthPrimaryButton(
              label: 'Continue',
              isLoading: controller.isLoading.value,
              onTap: controller.onSubmitTap,
            ),
          ),
        ],
      ),
    );
  }
}
