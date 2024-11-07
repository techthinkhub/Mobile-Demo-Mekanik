import 'package:get/get.dart';

import '../controllers/invoicemasuk_controller.dart';

class InvoicemasukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoicemasukController>(
      () => InvoicemasukController(),
    );
  }
}
