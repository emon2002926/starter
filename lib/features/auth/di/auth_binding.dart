
import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';
import '../controllers/otp_controller.dart';
import '../controllers/reset_password_controller.dart';
import '../controllers/sign_in_controller.dart';
import '../controllers/sign_up_controller.dart';

class AuthBinding {
  static void authDependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
    Get.lazyPut<EnterOtpController>(
      () => EnterOtpController(),
    );
  }
}
