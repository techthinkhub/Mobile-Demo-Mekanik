import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../common/common.dart';
import '../widgets/custom_widget.dart';
import 'fade_animationtest.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xffF7EBE1).withAlpha(200),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 0.9,
                        child: Text(
                          "Halo! Daftar untuk mendapatkan  ",
                          style: Common().titelTheme,
                        ),
                      ),
                      FadeInAnimation(
                        delay: 1.2,
                        child: Text(
                          "Masuk",
                          style: Common().titelTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      children: [
                        const FadeInAnimation(
                          delay: 1.5,
                          child: CustomTextFormField(
                            hinttext: 'Nama Lengkap',
                            obsecuretext: false,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const FadeInAnimation(
                          delay: 1.8,
                          child: CustomTextFormField(
                            hinttext: 'Email',
                            obsecuretext: false,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: TextFormField(
                            obscureText: flag ? true : false,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18),
                                hintText: "Kata Sandi",
                                hintStyle: Common().hinttext,
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.4,
                          child: TextFormField(
                            obscureText: flag ? true : false,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18),
                                hintText: "Konfirmasi sandi",
                                hintStyle: Common().hinttext,
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 2.7,
                          child: CustomElevatedButton(
                            message: "Register",
                            function: () {},
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 2.9,
                          child: Text(
                            "Atau Daftar dengan",
                            style: Common().semiboldblack,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 3.2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/facebook_ic (1).svg"),
                                SvgPicture.asset(
                                    "assets/images/google_ic-1.svg"),
                                Image.asset("assets/images/Vector.png")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInAnimation(
                  delay: 3.6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya Akun ?",
                          style: Common().hinttext,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(const LoginPage());
                            },
                            child: Text(
                              "Login Sekarang",
                              style: Common().mediumTheme,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
