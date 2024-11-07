import 'package:get/get.dart';

import '../controllers/repair_maintenen_controller.dart';

class RepairMaintenenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepairMaintenenController>(
      () => RepairMaintenenController(),
    );
  }
}
