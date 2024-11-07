import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';
import '../screens/login_page.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
