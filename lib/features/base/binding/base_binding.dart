
import 'package:get/get.dart';


import '../controllers/base_controller.dart';

class BaseBinding {
  static void dependencies() {

    Get.lazyPut<BaseController>(
      () => BaseController(),
      fenix: true,
    );

    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    //   fenix: true,
    // );

  }
}