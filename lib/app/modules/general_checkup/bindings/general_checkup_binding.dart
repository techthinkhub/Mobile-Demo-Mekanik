import 'package:get/get.dart';

import '../controllers/general_checkup_controller.dart';

class GeneralCheckupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralCheckupController>(
      () => GeneralCheckupController(),
    );
  }
}
