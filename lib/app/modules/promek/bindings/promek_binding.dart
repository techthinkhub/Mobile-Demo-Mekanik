import 'package:get/get.dart';

import '../controllers/promek_controller.dart';

class PromekBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromekController>(
      () => PromekController(),
    );
  }
}
