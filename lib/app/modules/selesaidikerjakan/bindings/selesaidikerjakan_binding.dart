import 'package:get/get.dart';

import '../controllers/selesaidikerjakan_controller.dart';

class SelesaidikerjakanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelesaidikerjakanController>(
      () => SelesaidikerjakanController(),
    );
  }
}
