

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api/services/api_services.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/form_validator.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/otp_verification_screen.dart';

class ForgotPasswordController extends GetxController {
  final _api = Get.find<ApiServices>();

  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  final RxBool isLoading = false.obs;

  void onSubmitTap() async {
    final email = emailController.text.trim();

    AppNavigation.push(
      OtpVerificationScreen(
        email: email,
        isFromSignUp: false,
      ),
    );
    // final isValid = FormValidator.validateAll([
    //   FormFieldEntry(
    //     value: email,
    //     errorMessage: 'Enter a valid email',
    //     focusNode: emailFocus,
    //   ),
    // ]);
    // if (!isValid) return;
    //
    // isLoading.value = true;
    // try {
    //   final response = await _api.post(
    //     "/auth/forgot-password/",
    //     body: {'email': email},
    //   );
    //
    //   CustomSnackBar.success(response.message ?? 'OTP sent successfully');
    //   AppNavigation.push(
    //     OtpVerificationScreen(
    //       email: email,
    //       isFromSignUp: false,
    //     ),
    //   );
    // } on HttpException catch (e) {
    //   // Handled by API services
    // } catch (_) {
    //   // Handled by API services
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocus.dispose();
    super.onClose();
  }
}
