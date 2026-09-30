import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api/services/api_services.dart';
import '../../../core/util/app_navigation.dart';
import '../../../core/util/form_validator.dart';
import '../../../core/util/storage_service.dart';
import '../../../core/widgets/snakbar/custom_snackbar.dart';
import '../../base/views/base_page.dart';
import '../views/reset_password_screen.dart';

class EnterOtpController extends GetxController {
  final _api = Get.find<ApiServices>();

  final otpController = TextEditingController();
  final otpFocus = FocusNode();

  final RxBool isLoading = false.obs;
  final RxBool canResend = false.obs;
  final RxInt secondsRemaining = 60.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    canResend.value = false;
    secondsRemaining.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        t.cancel();
      }
    });
  }

  String get formattedTime {
    final s = secondsRemaining.value;
    return '0:${s.toString().padLeft(2, '0')}';
  }

  void onResendTap(String email, bool isFromSignUp) async {




    if (!canResend.value) return;
    try {
      final endpoint = isFromSignUp ? "/auth/resend-verification-otp/" : "/auth/forgot-password/";
      final response = await _api.post(
        endpoint,
        body: {'email': email},
      );

      CustomSnackBar.success(response.message ?? 'OTP resent to $email');
      _startTimer();
    } on HttpException catch (e) {
      // CustomSnackBar.error(e.message);
    } catch (_) {
      // CustomSnackBar.error('Something went wrong');
    }
  }

  void onSubmitTap(String email, bool isFromSignUp) async {

    if(isFromSignUp){
      AppNavigation.pushAndClear(const BasePage());

    }else{
      AppNavigation.pushAndClear(ResetPasswordScreen(
        email: email,
        code: otpController.text.trim(),
      ));

    }
    // final isValid = FormValidator.validateAll([
    //   FormFieldEntry(
    //     value: otpController.text.trim(),
    //     errorMessage: 'Please enter the 6-digit OTP',
    //     focusNode: otpFocus,
    //   ),
    // ]);
    // if (!isValid) return;
    //
    // if (otpController.text.trim().length != 6) {
    //   CustomSnackBar.error('OTP must be exactly 6 digits');
    //   otpFocus.requestFocus();
    //   return;
    // }
    //
    // isLoading.value = true;
    // try {
    //   if (isFromSignUp) {
    //     final response = await _api.post(
    //       "/auth/verify-otp/",
    //       body: {
    //         'email': email,
    //         'code': otpController.text.trim(),
    //       },
    //     );
    //
    //     final token = response.get<String>('token');
    //     final refresh = response.get<String>('refresh');
    //
    //     if (token != null && refresh != null) {
    //       await StorageService.saveToken(token);
    //       await StorageService.saveRefreshToken(refresh);
    //     }
    //
    //     AppNavigation.pushAndClear(const BasePage());
    //   } else {
    //     final response = await _api.post(
    //       "/auth/verify-reset-otp/",
    //       body: {
    //         'email': email,
    //         'code': otpController.text.trim(),
    //       },
    //     );
    //
    //     AppNavigation.pushAndClear(ResetPasswordScreen(
    //       email: email,
    //       code: otpController.text.trim(),
    //     ));
    //   }
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
    _timer?.cancel();
    otpController.dispose();
    otpFocus.dispose();
    super.onClose();
  }
}
