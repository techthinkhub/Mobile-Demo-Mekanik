import 'package:get/get.dart';

import '../controllers/bookingmasuk_controller.dart';

class BookingmasukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingmasukController>(
      () => BookingmasukController(),
    );
  }
}
