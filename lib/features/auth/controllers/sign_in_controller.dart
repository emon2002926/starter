import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/features/base/views/base_page.dart';

import '../../../core/services/api/services/api_services.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/form_validator.dart';
import '../../../core/util/storage_service.dart';

class SignInController extends GetxController {
  final _api = Get.find<ApiServices>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  void togglePassword() => obscurePassword.toggle();

  void onSubmitTap() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    AppNavigation.push(const BasePage());

    // final isValid = FormValidator.validateAll([
    //   FormFieldEntry(
    //     value: email,
    //     errorMessage: 'Enter a valid email',
    //     focusNode: emailFocus,
    //   ),
    //   FormFieldEntry(
    //     value: password,
    //     errorMessage: 'Enter your password',
    //     focusNode: passwordFocus,
    //   ),
    // ]);
    // if (!isValid) return;
    //
    // isLoading.value = true;
    // try {
    //   final response = await _api.post(
    //     "/auth/login/",
    //     body: {
    //       'email': email,
    //       'password': password,
    //     },
    //   );
    //
    //   final token = response.get<String>('token');
    //   final refresh = response.get<String>('refresh');
    //
    //   if (token != null && refresh != null) {
    //     await StorageService.saveToken(token);
    //     await StorageService.saveRefreshToken(refresh);
    //   }
    //
    //   AppNavigation.push(const BasePage());
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
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}