import 'package:get/get.dart';

import '../controllers/selesaiservice_controller.dart';

class SelesaiserviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelesaiserviceController>(
      () => SelesaiserviceController(),
    );
  }
}
