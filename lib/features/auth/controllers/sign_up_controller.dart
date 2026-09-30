import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api/services/api_services.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/form_validator.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/otp_verification_screen.dart';

class SignUpController extends GetxController {
  final _api = Get.find<ApiServices>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  void togglePassword() => obscurePassword.toggle();
  void toggleConfirm() => obscureConfirm.toggle();

  void onSubmitTap() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmController.text;
    AppNavigation.push(
      OtpVerificationScreen(
        email: email,
        isFromSignUp: true,
      ),
    );

    // final isValid = FormValidator.validateAll([
    //   FormFieldEntry(
    //     value: name,
    //     errorMessage: 'Please fill in all fields',
    //     focusNode: nameFocus,
    //   ),
    //   FormFieldEntry(
    //     value: email,
    //     errorMessage: 'Enter a valid email',
    //     focusNode: emailFocus,
    //   ),
    //   FormFieldEntry(
    //     value: password,
    //     errorMessage: 'Password must be at least 8 characters',
    //     focusNode: passwordFocus,
    //   ),
    //   FormFieldEntry(
    //     value: confirm,
    //     errorMessage: 'Passwords do not match',
    //     focusNode: confirmFocus,
    //   ),
    // ]);
    // if (!isValid) return;
    //
    // if (password != confirm) {
    //   CustomSnackBar.error('Passwords do not match');
    //   confirmFocus.requestFocus();
    //   return;
    // }
    //
    // isLoading.value = true;
    // try {
    //   final response = await _api.post(
    //     "/auth/register/",
    //     body: {
    //       'email': email,
    //       'username': name, // Using name as username based on standard fields
    //       'password': password,
    //     },
    //   );
    //
    //   CustomSnackBar.success(response.message ?? 'OTP sent successfully');
    //   AppNavigation.push(
    //     OtpVerificationScreen(
    //       email: email,
    //       isFromSignUp: true,
    //     ),
    //   );
    // } on HttpException catch (e) {
    //   // Handled by api service
    // } catch (_) {
    //   // Handled by api service
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();
    super.onClose();
  }
}
