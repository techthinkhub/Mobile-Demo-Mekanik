import 'package:get/get.dart';

import '../controllers/approve_controller.dart';

class ApproveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApproveController>(
      () => ApproveController(),
    );
  }
}
