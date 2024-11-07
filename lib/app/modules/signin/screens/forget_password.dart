import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:mekanik/app/modules/signin/screens/signup_page.dart';

import '../common/common.dart';
import '../router/router.dart';
import '../widgets/custom_widget.dart';
import 'fade_animationtest.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Tidak ingat kata sandi?",
                        style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Jangan khawatir! Ini terjadi. Silakan masukkan alamat email yang tertaut dengan akun Anda.",
                        style: Common().mediumThemeblack,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Column(
                    children: [
                      const FadeInAnimation(
                        delay: 1.9,
                        child: CustomTextFormField(
                          hinttext: 'Masukkan email Anda',
                          obsecuretext: false,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: CustomElevatedButton(
                          message: "Kirim Kode",
                          function: () {
                            GoRouter.of(context)
                                .pushNamed(Routers.otpverification.name);
                          },
                          color: MyColors.appPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
