
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/screen_size.dart';
import '../controllers/forgot_password_controller.dart';
import '../widgets/auth_fields.dart';
import '../widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    return AuthScaffold(
      showBack: true,
      title: 'Forgot password?',
      subtitle: 'Enter your work email and we\'ll send a 6-digit OTP to verify your identity.',
      icon: Icons.key_rounded,
      child: Column(
        children: [
          AuthTextField(
            label: 'Email',
            hintText: 'sarah.j@averymarsh.com',
            controller: controller.emailController,
            focusNode: controller.emailFocus,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline_rounded,
          ),
          SizedBox(height: context.h(28)),
          Obx(
            () => AuthPrimaryButton(
              label: 'Send OTP Code',
              isLoading: controller.isLoading.value,
              onTap: controller.onSubmitTap,
            ),
          ),
        ],
      ),
    );
  }
}
