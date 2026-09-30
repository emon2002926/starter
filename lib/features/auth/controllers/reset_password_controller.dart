

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api/services/api_services.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/form_validator.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../views/sign_in_screen.dart';

class ResetPasswordController extends GetxController {
  final _api = Get.find<ApiServices>();

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  void togglePassword() => obscurePassword.toggle();
  void toggleConfirm() => obscureConfirm.toggle();

  void onSubmitTap(String email, String code) async {
    final password = passwordController.text;
    final confirm = confirmController.text;

    final isValid = FormValidator.validateAll([
      FormFieldEntry(
        value: password,
        errorMessage: 'Password must be at least 8 characters',
        focusNode: passwordFocus,
      ),
      FormFieldEntry(
        value: confirm,
        errorMessage: 'Passwords do not match',
        focusNode: confirmFocus,
      ),
    ]);
    if (!isValid) return;

    if (password != confirm) {
      CustomSnackBar.error('Passwords do not match');
      confirmFocus.requestFocus();
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post(
        "/auth/reset-password/",
        body: {
          'email': email,
          'code': code,
          'new_password': password,
        },
      );

      CustomSnackBar.success(response.message ?? 'Password updated successfully');
      AppNavigation.pushAndClear(const SignInScreen());
    } on HttpException catch (e) {
      // Handled by API services
    } catch (_) {
      // Handled by API services
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmController.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();
    super.onClose();
  }
}
