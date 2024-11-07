import 'package:get/get.dart';

import '../controllers/boking_controller.dart';

class BokingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BokingController>(
      () => BokingController(),
    );
  }
}
