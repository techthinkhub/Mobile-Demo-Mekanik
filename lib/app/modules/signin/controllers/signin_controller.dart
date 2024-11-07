import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/endpoint.dart';

class SigninController extends GetxController {
  //TODO: Implement SigninController
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final API fetchData = API();
  final count = 0.obs;
  var response = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
