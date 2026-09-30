
import '../../features/auth/di/auth_binding.dart';
import '../../features/base/binding/base_binding.dart';

class AppBindings {
  AppBindings._();
  static void init() {

    AuthBinding.authDependencies();
    // QuestionBankBinding.questionBankDependencies();
    BaseBinding.dependencies();
    // AccountBinding.dependencies();
    // ProjectsBinding.dependencies();
    // LattiAiBinding.dependencies();
  }

}