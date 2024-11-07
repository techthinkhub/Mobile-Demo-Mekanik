import 'package:get/get.dart';

import '../controllers/splashcreen_controller.dart';

class SplashcreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashcreenController>(
      () => SplashcreenController(),
    );
  }
}
