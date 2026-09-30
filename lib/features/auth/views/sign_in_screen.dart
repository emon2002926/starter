import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/app_navigation.dart';
import '../../../core/util/screen_size.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/auth_fields.dart';
import '../widgets/auth_scaffold.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInController>();

    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to your construction workspace',
      icon: null,
      footer: AuthFooterLink(
        prompt: 'Don\'t have an account?',
        action: 'Sign Up',
        onTap: () => AppNavigation.push(const SignUpScreen(), context: context),
      ),
      // header: Image.asset(
      //   'assets/applogo.png',
      //   height: 50,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTextField(
            label: 'Work Email',
            hintText: 'sarah.j@averymarsh.com',
            controller: controller.emailController,
            focusNode: controller.emailFocus,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline_rounded,
          ),
          SizedBox(height: context.h(16)),
          Obx(
            () => AuthTextField(
              label: 'Password',
              hintText: '••••••••••••',
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
                      side: const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Remember me',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => AppNavigation.push(
                  const ForgotPasswordScreen(),
                  context: context,
                ),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(28)),
          Obx(
            () => AuthPrimaryButton(
              label: 'Sign In',
              isLoading: controller.isLoading.value,
              onTap: controller.onSubmitTap,
            ),
          ),
        ],
      ),
    );
  }
}
