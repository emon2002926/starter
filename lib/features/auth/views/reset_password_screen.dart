
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../controllers/reset_password_controller.dart';
import '../widgets/auth_fields.dart';
import '../widgets/auth_scaffold.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    return AuthScaffold(
      showBack: true,
      title: 'Set new password',
      subtitle: 'Create a strong new password for your Averymarsh account.',
      icon: Icons.lock_outline_rounded,
      child: Column(
        children: [
          Obx(
            () => AuthTextField(
              label: 'New Password',
              hintText: 'Min 8 characters',
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
              label: 'Confirm Password',
              hintText: 'Repeat new password',
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
              label: 'Reset Password',
              isLoading: controller.isLoading.value,
              onTap: () => controller.onSubmitTap(email, code),
            ),
          ),
        ],
      ),
    );
  }
}
