import 'package:get/get.dart';

import '../controllers/emergency_controller.dart';

class mergencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyController>(
      () => EmergencyController(),
    );
  }
}
